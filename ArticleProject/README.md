# ArticleProject

### 프로젝트 소개 
<div align="center">
<img src = "https://github.com/elisha0103/UIKit/assets/41459466/beb6939a-05c9-4253-bb5a-3e8064114b6a">
</div>
<br>

### 프로젝트 목표
> - [NEWS API](https://newsapi.org)를 사용해 뉴스 기사 검색하기
> - 기본 라이브러리로 Network 추상화 모듈 구현하여 서드파티 라이브러리의 Network 모듈 작동 방식을 학습하기
> - API 응답 데이터를 통해 메인 이미지 나타내기
> - Pagination 사용하여 무한 스크롤 사용해보기
> - API로부터 받아온 이미지를 기기 메모리 / 디스크 캐시하여 자원 절약하기

<br>

### 개발 환경

- Deployment Target: iOS 15.0
- Architecture: MVC, Singleton
- Framework: UIKit

<br>

## Foldering
 

```

ArticleProject
├── Network
├── Model
├── Protocol
├── Extension
└── ViewController
ArticleProjectTests

```

<br>

## Feature-1. 검색화면 구현
### 주요 기능 

- 사용자가 TextField에 입력한 Text를 바탕으로 검색 결과를 받아옴
- 기본 라이브러리로 Network 추상화 모듈 구현
- 하나의 Network 모듈로 다양한 모델의 네트워크 응답 구현 (네트워크 테스트 코드 작성)
- Pagination을 통해 스크롤을 화면 최하단으로 내리면 다음 데이터를 받아옴(추가 데이터가 없으면 반환 안함)
- Refresh 기능 구현
- Cell 선택시 해당 NEWS 사이트로 연결

<br>

## Feature-2. Cover Image 불러오기 구현
### 주요 기능

- NEWS 검색으로 응답받은 데이터(Article)를 사용하여 메인 이미지 데이터를 네트워크 모듈로부터 받아옴
- 최초 API를 통해 받아온 이미지 데이터를 메모리 / 디스크에 데이터 저장
- 이미지를 다시 호출할 때, 메모리로부터 데이터를 요청 -> (실패) -> 디스크로부터 메모리 요청 -> (실패) -> API를 통해 데이터 요청

<br>

## 구현 화면

<div align="center">
 
|<img src="https://github.com/elisha0103/UIKit/assets/41459466/72c30e12-9a25-4446-b2ff-137ce310a938" width="200" height="400"/></img>|<img src="https://github.com/elisha0103/UIKit/assets/41459466/87abbac0-273d-4d28-afa8-9e7d6a09dfac" width="200" height="400"/></img>|
|:-:|:-:|
|`메인, Pagination 구현 화면`|`검색, WebView 연결`|
 
</div>
<br>

## Troubleshooting
### **Cache 관련**
<div align="center">
<img src="https://github.com/elisha0103/UIKit/assets/41459466/c2c83ff5-7a4c-44d7-872f-ba65193ab00c" width="200" height="400"/>
</div>

- 문제:  Network로부터 이미지 데이터를 받아올 때 NEWS 기사와 일치하는 이미지 데이터가 UITableViewCell에 정상 할당되지만, Cache 이미지를 불러올 때에는 기사와 상관없는 이미지가 일부 UITableViewCell에 중복 할당 됨

<br>

<div align="center">
<img src="https://github.com/elisha0103/UIKit/assets/41459466/ad6c96df-b76c-4b16-9048-e1d23073a0b9" width="600" height="180"/>
</div>

```

var filePath = URL(fileURLWithPath: path)
filePath.appendPathComponent(url.lastPathComponent)

...

self.fileManager.createFile(atPath: filePath.path, contents: img.jpegData(CompressionQuality: 0.4))

```

- 원인: 이미지 URL의 마지막 Component 값을 활용하여 Cache 파일 저장 경로 설정 후 이미지 파일을 저장하는데, 마지막 Component가 중복되는 이미지 URL이 존재(ex: 840_560.jpeg)
따라서 이미지 URL은 다르지만, 마지막 Component의 값이 같아 캐시 파일이 존재하는 경로에 새로운 파일을 덮어쓰기하여 Cache 데이터를 불러올 때, 기사와 맞지 않은 데이터를 UITableViewCell에 할당 함
 
<br>

<div align="center">
<img src="https://github.com/elisha0103/UIKit/assets/41459466/60937569-341f-41b5-8024-b9e73bbe767c" width="600" height="180"/>
</div>

```

    // cache 경로 생성
    func makeCacheKey(url: URL) -> URL? {
        // 디스크 캐시 폴더
        guard let diskCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return nil }
        
        var filePath = URL(fileURLWithPath: diskCachePath)
        
        var urlsPathComponents = url.pathComponents
        urlsPathComponents.removeFirst()
        filePath.appendPathComponent(urlsPathComponents.joined(separator: ""))
        
        return filePath
    }

```

- 해결: NEWS 기사별로 고유한 Cache 경로를 갖도록 이미지 URL의 모든 Component를 활용 (URL의 첫 Component는 '/'이기 때문에 첫 번째 항목 삭제 후 하나의 문자열로 합성하여 Cache 경로 설정)

<br>
<br>
    
### **View 관련**
<div align="center">
<img src="https://github.com/elisha0103/UIKit/assets/41459466/cc0f1e8f-20b8-4b48-a7d0-9d21a329fc1f" width="600" height="180"/>
</div>

- 문제: 검색 View Refresh 할 때, 서버에 page 1(Refresh request), page 2(Pagination request) 데이터를 연속으로 요청

<br>

```

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = tableView.contentOffset.y
        let tableViewContentSize = tableView.contentSize.height
        
        if contentOffset_y > (tableViewContentSize - tableView.bounds.size.height), isPaginationFetching {
            print("page plus")
            if let searchText = self.searchText {
                let articleRequest: ArticleRequest = ArticleRequest(q: "\(searchText)", page: page ?? 1)
                getArticleResponse(request: articleRequest)
                
                return
            }
            
            let headlineArticleReqeust: HeadlineArticleRequest = HeadlineArticleRequest(country: "kr", page: page ?? 1)
            getArticleResponse(request: headlineArticleReqeust)
            
            return
        }
    }

```

- 원인: Refresh를 하기 위해서 화면을 위로 스크롤 하는데, 이 때 scrollViewDidScroll 함수가 실행되어 if 조건문 코드 블록 때문에 데이터를 연속으로 요청하게 됨

<br>

```

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = tableView.contentOffset.y
        let tableViewContentSize = tableView.contentSize.height
        
        // contentOffset_y > 0은 refresh할 때에는 중복된 패치가 이뤄지지 않도록 하기 위함
        // 아래 구문은 아래로 스크롤할 때에만 적용되게 하기 위한 예외처리
        if contentOffset_y > (tableViewContentSize - tableView.bounds.size.height), isPaginationFetching, contentOffset_y > 0 {
            print("page plus")
            if let searchText = self.searchText {
                let articleRequest: ArticleRequest = ArticleRequest(q: "\(searchText)", page: page ?? 1)
                getArticleResponse(request: articleRequest)
                
                return
            }
            
            let headlineArticleReqeust: HeadlineArticleRequest = HeadlineArticleRequest(country: "kr", page: page ?? 1)
            getArticleResponse(request: headlineArticleReqeust)
            
            return
        }
    }

```

- 해결: Pagination 기능 함수는 아래로 스크롤 할 때만 실행되도록 조건문에 'contentOffset_y > 0' 을 추가 (위로 스크롤 할 때에는 'contentOffset_y'의 값이 음수임)

<br>

## 활용기술

#### Platforms

<img src="https://img.shields.io/badge/iOS-5A29E4?style=flat&logo=iOS&logoColor=white"/>  

<br>
    
#### Language & Tools

<img src="https://img.shields.io/badge/Xcode-147EFB?style=flat&logo=Xcode&logoColor=white"/> <img src="https://img.shields.io/badge/UIKit-%232396F3.svg?&style=flat&logo=UIKit&logoColor=white" /> <img src="https://img.shields.io/badge/Swift-F05138?style=flat&logo=swift&logoColor=white"/>


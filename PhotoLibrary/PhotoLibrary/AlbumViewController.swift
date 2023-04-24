//
//  AlbumViewController.swift
//  PhotoLibrary
//
//  Created by 진태영 on 2023/04/24.
//

import UIKit
import Photos

class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PHPhotoLibraryChangeObserver {
   
    @IBOutlet weak var sortToolbarItem: UIBarButtonItem!
    @IBOutlet weak var actionToolbarItem: UIBarButtonItem!
    @IBOutlet weak var trashToolbarItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var buttonStatus = false
    var album: Album!
    var albumIndex: Int!
    
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    let half: Double = Double(UIScreen.main.bounds.width/3 - 15)
    
    @IBOutlet weak var myrightBarButtonItem: UIBarButtonItem! // Navigation의 선택 버튼
    
    
    var delete: [Int] = [] // 삭제 index 담는 배열
    
    var stop: Bool = false // 다음 View로 넘어가지 않도록 하는 flag 변수
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.isSynchronous = true
        options.resizeMode = .exact

        guard let cell: AssetCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "asset", for: indexPath) as? AssetCollectionViewCell else {
            print("cell error")
            return UICollectionViewCell()
            
        }
        print("indexPath: \(indexPath.item)")
        let picture: PHAsset = album.asset.object(at: indexPath.item)
        
        imageManager.requestImage(for: picture, targetSize: CGSize(width: half, height: half), contentMode: .aspectFill, options: options) { image, _ in
            print("image: \(String(describing: image?.description))")
            cell.imageView.image = image
        }
        
        cell.backgroundColor = UIColor.white // 선택 초기화
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album.asset.count
    }
    
    // 포토 라이브러리 변화시
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: album.asset) else { return }
        
        album.asset = changes.fetchResultAfterChanges // 바뀐 값 다시 조정
        
        // 바뀌어서 다시 로드
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
    
    // 셀 선택시 호출되는 함수
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.7
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.black
        
        // 선택된 배열 인덱스 저장 중복시 저장 안함
        if !delete.contains(indexPath.item) {
            delete.append(indexPath.item)
        }
        print(delete)
        
        if !stop {  // 이렇게 하는 이유는 선택 상황이 다르기 때문에. 무조건 선택한다고 다음 View로 넘겨주는 로직이 아니기 때문에 코드로 작성
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailView") else {
                print("View Controller not found")
                return
            }
            
            // 다음 ViewController 호출
            let detailViewController: DetailViewController = vc as! DetailViewController
            
            // 선택된 셀에 대한 접근
            let cell: AssetCollectionViewCell = collectionView.cellForItem(at: indexPath) as! AssetCollectionViewCell
            
            // detailViewController 내 변수에 이미지 대입
            detailViewController.asset = cell.imageView.image
            
            // 앨범 정보 대입
            detailViewController.album = self.album
            detailViewController.index = indexPath.item
            
            // VC 추가
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    // 선택된 셀 선택 취소시
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.white
        
        let index: Int! = delete.firstIndex(of: indexPath.item)
        delete.remove(at: index)
        print("delete: \(delete)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: half, height: half)
        flowlayout.sectionInset = UIEdgeInsets.zero
        flowlayout.minimumLineSpacing = 20
        flowlayout.minimumInteritemSpacing = 20
        self.collectionView.collectionViewLayout = flowlayout
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        print("albumName: \(album.name), \(String(describing: album))")
        self.navigationItem.title = album.name
        self.navigationItem.rightBarButtonItem = myrightBarButtonItem
        
        PHPhotoLibrary.shared().register(self)
        
    }
    
    @IBAction func selectbtAction(_ sender: UIBarButtonItem) -> Void {
        self.stop = true    // 다음 뷰로 안넘어 가도록
        self.actionToolbarItem.isEnabled = true // action 버튼 활성화
        self.trashToolbarItem.isEnabled = true  // 삭제 버튼 활성화
        self.navigationItem.title = "항목 선택" // 앨범 제목에서 항목 선택으로 변경
        self.navigationItem.hidesBackButton = true  // 뒤로가기 버튼 숨기기
        
        // 인터페이스 빌더에 없는 인터페이스를 추가하는 것이므로 #selector를 사용하여 작동
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelbtAction(_:))) // 선택 -> 취소로 버튼 변경
        
        self.collectionView.allowsMultipleSelection = true      // collectionView의 멀티 선택 허용
    }
    
    @objc func cancelbtAction(_ sender: UIBarButtonItem) -> Void {
        self.stop = false
        self.actionToolbarItem.isEnabled = false
        self.trashToolbarItem.isEnabled = false
        self.navigationItem.title = "선택"
        self.navigationItem.hidesBackButton = false
        self.navigationItem.rightBarButtonItem = myrightBarButtonItem
        
        self.delete = []
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.reloadData()
    }
    
    @IBAction func sortToolbarbt(_ sender: Any) {
        buttonStatus = !buttonStatus
        
        if buttonStatus {
            sortToolbarItem.title = "과거순"
            let reverseCreationDateFet = PHFetchOptions()
            reverseCreationDateFet.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            // 카메라 롤일경우
            if album.name == "Recent" {
                let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
                
                guard let userAlbum: PHAssetCollection = cameraRoll.firstObject else { return }
                album.asset = PHAsset.fetchAssets(in: userAlbum, options: reverseCreationDateFet)
            } else {
                // 사용자 생성 앨범 정렬
                let listfet = PHFetchOptions()
                listfet.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: false)]
                
                // 사용자 생성 앨범 정보 가져오기
                let userAlbumList: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: listfet)
                
                // 생성날짜 최근거부터 정렬(내림차순)
                let userAlbum: PHAssetCollection = userAlbumList.object(at: albumIndex - 1)
                album.asset = PHAsset.fetchAssets(in: userAlbum, options: reverseCreationDateFet)
            }
            collectionView.reloadData()

        } else { // 과거순 상태일 때
            sortToolbarItem.title = "최신순"
            
            let creationDateFet = PHFetchOptions()
            creationDateFet.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            
            // 카메라 롤일경우
            // 생성날짜 늦은거부터 정렬 (오름차순)
            if album.name == "Recent" {
                let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
                
                guard let userAlbum: PHAssetCollection = cameraRoll.firstObject else { return }
                album.asset = PHAsset.fetchAssets(in: userAlbum, options: creationDateFet)
            } else {
                // 사용자 생성 앨범 정렬
                let listfet = PHFetchOptions()
                listfet.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: false)]
                
                // 사용자 생성 앨범 정보 가져오기
                let userAlbumList: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: listfet)
                
                // 생성날짜 최근거부터 정렬 (내림차순)
                let userAlbum: PHAssetCollection = userAlbumList.object(at: albumIndex - 1)
                album.asset = PHAsset.fetchAssets(in: userAlbum, options: creationDateFet)
            }
            collectionView.reloadData()
        }
        
    }

    @IBAction func actionItemClick(_ sender: Any) {
        
    }
    
    @IBAction func trashItemClick(_ sender: Any) {
        var asset: [PHAsset] = []
        
        for i in delete {
            asset.append(album.asset[i])
        }
        
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.deleteAssets(asset as NSFastEnumeration)
        }
    }
    


}

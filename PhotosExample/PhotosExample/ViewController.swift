//
//  ViewController.swift
//  PhotosExample
//
//  Created by 진태영 on 2023/04/06.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PHPhotoLibraryChangeObserver {

    @IBOutlet weak var tableView: UITableView!
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager() // 많은 asset을 가져올 때 미리 캐싱하여 asset을 가지고 있다가 개별 asset을 요청하면 지연없이 바로 다룰 수 있도록 하는 객체
    let cellIdentifier: String = "cell"
    
    // 편집 가능하도록 하는 요소
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    
    // 테이블 뷰 편집시 수행되는 함수
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let asset: PHAsset = self.fetchResult[indexPath.row]
            
            // 사진첩에서 변화 수행 -> 삭제 변화 수행 -> 삭제 확인 뷰 생성
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.deleteAssets([asset] as NSArray)
            }
        }
    }
    
    func requestCollection() { // 컬랙션 요청 함수
        // 컬렉션 객체 생성
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        // 카메라롤 컬랙션 중 첫번째 항목 선택 (PHFetchResult - PHAssetCollection)
        guard let cameraRollCollection = cameraRoll.firstObject else {
            return
        }
        
        // 컬렉션 가져온 결과에 옵션 부여
        let fetchOptions = PHFetchOptions()
        // 패치 옵션 중 정렬 = 생성날짜에 따라 정렬
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // 패치 결과 = 사진들을 패치한다 -> 첫번째 컬렉션 객체에서, 생성날짜에 따라 정렬하여 나타냄
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
    
    // 사진첩 변화 수행 감지
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {return}
        
        // 변경사항 적용 후에 대한 fetchResult 데이터 반환
        fetchResult = changes.fetchResultAfterChanges
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 앨범 권한 요청
        let photoAurthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAurthorizationStatus {
        case .authorized:
            print("접근 허가됨")
            self.requestCollection()
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }

        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self.requestCollection()
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            }
        case .restricted:
            print("접근 제한")
            
         default:
            break
        }
        
        // 아이폰 기본 사진첩과 데이터를 공유하고 수행자를 해당 ViewController 객체가 수행한다
        PHPhotoLibrary.shared().register(self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        // 이미지 데이터 인스턴스 생성 = 패치 결과에 index에 해당하는 요소로 생성 PHFetchResult -> PHAsset
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        // 이미지 생성 요청
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil) { image, _ in
            cell.imageView?.image = image
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resourcs that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: ImageZoomViewController = segue.destination as? ImageZoomViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else { return }
        
        guard let index: IndexPath = self.tableView.indexPath(for: cell) else { return }
        
        nextViewController.asset = self.fetchResult[index.row]
    }


}


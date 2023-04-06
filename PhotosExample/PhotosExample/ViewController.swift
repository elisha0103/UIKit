//
//  ViewController.swift
//  PhotosExample
//
//  Created by 진태영 on 2023/04/06.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager() // 많은 asset을 가져올 때 미리 캐싱하여 asset을 가지고 있다가 개별 asset을 요청하면 지연없이 바로 다룰 수 있도록 하는 객체
    let cellIdentifier: String = "cell"
    
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


}


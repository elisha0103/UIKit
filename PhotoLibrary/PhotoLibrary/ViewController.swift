//
//  ViewController.swift
//  PhotoLibrary
//
//  Created by 진태영 on 2023/04/21.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var albums: [Album] = []
    let imageManager = PHCachingImageManager()
    
    let half: Double = Double(UIScreen.main.bounds.width/2 - 20)
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "album", for: indexPath) as? AlbumCollectionViewCell else {
            print("cell error")
            return UICollectionViewCell()
        }
        print("indexPath.item: \(indexPath.item)")
        print("앨범 총 개수: \(albums.count)")
        print("albums\(indexPath.item): \(albums[indexPath.item])")
        let asset: PHAsset? = albums[indexPath.item].asset.firstObject
        
        imageManager.requestImage(for: asset ?? PHAsset(), targetSize: CGSize(width: half, height: half), contentMode: .aspectFill, options: nil) { image, _ in
            cell.albumThumbnail.image = image
        }
        
        cell.albumName.text = albums[indexPath.item].name
        cell.albumPhotosCount.text = "\(albums[indexPath.item].numberOfAsset)"
        
        return cell
    }
    
    func requestCollections() {
        let fetchOptions = PHFetchOptions()
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let listfet = PHFetchOptions()
        listfet.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: false)]
        
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else { return }
        
        let asset: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
        
        albums.append(Album(asset: asset, name: cameraRollCollection.localizedTitle ?? "notitle", numberOfAsset: asset.count))
        
        let userAlbumList: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: listfet)
        let collections: [PHAssetCollection] = userAlbumList.objects(at: IndexSet(0..<userAlbumList.count))
        
        for index in 0..<userAlbumList.count {
            let asset: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: collections[index], options: fetchOptions)
            let newAlbum = Album(asset: asset, name: collections[index].localizedTitle ?? "Notitle", numberOfAsset: asset.count)
            albums.append(newAlbum)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heightsize: Double = half + 40
        self.navigationItem.title = "앨범"
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: half, height: heightsize)
        flowLayout.minimumLineSpacing = 40
        flowLayout.minimumInteritemSpacing = 20
        self.collectionView.collectionViewLayout = flowLayout
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가")
            self.requestCollections()
            self.collectionView.reloadData()
        case .denied:
            print("접근 불가")
        case .restricted:
            print("접근 제한")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self.requestCollections()
                    OperationQueue.main.addOperation {
                        self.collectionView.reloadData()
                    }
                case .denied:
                    print("사용자가 불허함")
                default:
                    break

                }
            }
            
        case .limited:
            print("제한됨")
        @unknown default:
            print("알수없는 반환")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("개수: \(self.albums.count)")
        return self.albums.count
    }

}


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
    
    let half: Double = min(Double(UIScreen.main.bounds.width/2 - 20), Double(UIScreen.main.bounds.height/2 - 20))
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.isSynchronous = true
        options.resizeMode = .exact
        
        guard let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "album", for: indexPath) as? AlbumCollectionViewCell else {
            print("cell error")
            return UICollectionViewCell()
        }
        print("indexPath.item: \(indexPath.item)")
        print("앨범 총 개수: \(albums.count)")
        print("albums\(indexPath.item): \(albums[indexPath.item])")
        if albums[indexPath.item].numberOfAsset != 0 {
            let asset: PHAsset? = albums[indexPath.item].asset.firstObject
            
            imageManager.requestImage(for: asset ?? PHAsset(), targetSize: CGSize(width: half, height: half), contentMode: .aspectFill, options: options) { image, _ in
                cell.albumThumbnail.image = image
                print("albumName: \(self.albums[indexPath.item].name)")
                print("imageSize width x height: \(String(describing: cell.albumThumbnail.image?.size))")
            }
        } else {
            print("Dosen't exist asset")
        }
        
        cell.albumName.text = albums[indexPath.item].name
        cell.albumPhotosCount.text = "\(albums[indexPath.item].numberOfAsset)"
        
        return cell
        
        
        
    }
    
    func requestCollections() {
        let fetchOptions = PHFetchOptions()
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)] // 컬랙션 내 사진 리스트 패치
        
        let listfet = PHFetchOptions()
        listfet.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: false)] // 컬랙션 리스트 패치(앨범)
        
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil) // 컬랙션 리스트 패치
        
        guard let cameraRollCollection = cameraRoll.firstObject else { return }
        
        let asset: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions) // 컬랙션 내 사진 리스트 패치
        
        albums.append(Album(asset: asset, name: cameraRollCollection.localizedTitle ?? "notitle", numberOfAsset: asset.count)) // 앨범 배열에 추가
        
        // 위에는 Recents 등 Smart 앨범 추가한 내용 아래는 사용자 앨범 추가하는 내용
        
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
        
        flowLayout.sectionInset = UIEdgeInsets.zero
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            guard let nextView: AlbumViewController = segue.destination as? AlbumViewController else {
                return
            }
            
            guard let cell: AlbumCollectionViewCell = sender as? AlbumCollectionViewCell else { return }
            
            guard let index: IndexPath = self.collectionView.indexPath(for: cell) else { return }
            print("View 전환 전 데이터 : \(Album(asset: albums[index.item].asset, name: albums[index.item].name, numberOfAsset: albums[index.item].numberOfAsset).name)")
            nextView.album = Album(asset: albums[index.item].asset, name: albums[index.item].name, numberOfAsset: albums[index.item].numberOfAsset)
            nextView.albumIndex = index.item
            print(index.item)
    }

    
}


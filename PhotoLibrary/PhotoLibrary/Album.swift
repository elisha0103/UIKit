//
//  Album.swift
//  PhotoLibrary
//
//  Created by 진태영 on 2023/04/21.
//

import Foundation
import UIKit
import Photos

struct Album {
    var asset: PHFetchResult<PHAsset>
    var name: String
    var numberOfAsset: Int
}

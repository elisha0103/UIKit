//
//  CollectionViewSection.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/29.
//

import Foundation

// 레이아웃
enum Section: Hashable {
    // CollectionView의 Section을 기준으로 나눈다.
    case double
    case banner
    case horizontal(String)
    case vertical(String)
}

// 셀
enum Item: Hashable {
    // Section의 Cell을 기준으로 나눈다.
    case normal(Content)
    case bigImage(Movie)
    case list(Movie)
}

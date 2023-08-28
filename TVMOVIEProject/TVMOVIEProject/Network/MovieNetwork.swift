//
//  MovieNetwork.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/28.
//

import Foundation
import RxSwift

final class MovieNetwork {
    private let network: Network<MovieListModel>
    
    init(network: Network<MovieListModel>) {
        self.network = network
    }
    
    func getNowPlayingList() -> Observable<MovieListModel> {
        return network.getItemList(path: "/movie/top_rated")
    }
    
    func getPopularList() -> Observable<MovieListModel> {
        return network.getItemList(path: "/movie/popular")
    }
    
    func getUpcoming() -> Observable<MovieListModel> {
        return network.getItemList(path: "/movie/upcoming")
    }
}

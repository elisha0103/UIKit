//
//  TVNetwork.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/28.
//

import Foundation
import RxSwift

final class TVNetwork {
    private let network: Network<TVListModel>
    
    init(network: Network<TVListModel>) {
        self.network = network
    }
    
    func getTopRatedList() -> Observable<TVListModel> {
        return network.getItemList(path: "/tv/top_rated")
    }
}

//
//  ViewModel.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/28.
//

import Foundation
import RxSwift

class ViewModel {
    let disposeBag = DisposeBag()
    private let tvNetwork: TVNetwork
    private let movieNetwork: MovieNetwork
    
    init() {
        let provider = NetworkProvider()
        self.tvNetwork = provider.makeTVNetwork()
        self.movieNetwork = provider.makeMovieNetwork()
    }
    
    struct Input {
        let tvTrigger: Observable<Void>
        let movieTrigger: Observable<Void>
    }
    
    struct Output {
        let tvList: Observable<[TV]>
        let movieResult: Observable<MovieResult>
    }
    
    func transform(input: Input) -> Output {
        
        // trigger 발동하면, Network 패치 실행 -> 반환 값을 VC에 전달
        // VC에서는 반환 값을 구독
        
        // tvTrigger -> Obervable<Void> -> Observable<[TV]>, 입력된 Void타입 Input에 맞는 [TV] Output이 나와야하므로 flatMap 수정자 사용
        
        let tvList = input.tvTrigger.flatMapLatest { [unowned self] _ -> Observable<[TV]> in
            return self.tvNetwork.getTopRatedList().map{ $0.results }
        }
                
        let movieResult = input.movieTrigger.flatMapLatest { [unowned self] _ -> Observable<MovieResult> in
            // combineLatest - 다수의 Observable을 하나의 Observable로 합친다.
            // Observable 1, 2, 3의 결과 값을 하나의 상위 타입으로 사용하여 반환 (모든 Observable이 반환 되어야 정상적으로 작도
            return Observable.combineLatest(self.movieNetwork.getUpcoming(), self.movieNetwork.getPopularList(), self.movieNetwork.getNowPlayingList()) { upcoming, popular, nowPlaying -> MovieResult in
                
                return MovieResult(upcoming: upcoming, popular: popular, nowPlaying: nowPlaying)
            }
        }
        
        return Output(tvList: tvList, movieResult: movieResult)
    }
}

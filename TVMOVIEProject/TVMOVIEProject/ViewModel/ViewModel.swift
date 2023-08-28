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
    
    struct Input {
        let tvTrigger: Observable<Void>
        let movieTrigger: Observable<Void>
    }
    
    struct Output {
        let tvList: Observable<[TV]>
//        let movieList: Observable<MovieResult>
    }
    
    func transform(input: Input) -> Output {
        
        input.tvTrigger.bind {
            print("Trigger Input Bind")
        }.disposed(by: disposeBag)
        
        return Output(tvList: Observable<[TV]>.just([]))
    }
}

//
//  ViewController.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/28.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    
    let buttonView = ButtonView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let viewModel = ViewModel()
    
    // Subject - 이벤트를 발생 시키면서, 다른 곳에서 이벤트를 받을 수 있는 것
    // ButtonView에서 발생되는 이벤트를 구독하면서, ViewModel에 이벤트를 전달도 해야하기 때문에 Subject를 사용
    let tvTrigger = PublishSubject<Void>()
    let movieTrigger = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    private func configure() {
        configureUI()
        bindViewModel()
        bindView()
    }
    
    private func configureUI() {
        view.addSubview(buttonView)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBlue
        
        buttonView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(buttonView.snp.bottom)
        }
    }
    
    private func bindViewModel() {
        // 이벤트 발생 송신개념으로 Observable 형태로 Input 구조체에 전달, 이벤트 발생을 전달
        let input = ViewModel.Input(tvTrigger: tvTrigger.asObservable(), movieTrigger: movieTrigger.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.tvList.bind { tvList in
            print(tvList)
        }
        .disposed(by: disposeBag)
    }
    
    private func bindView() {
        buttonView.tvButton.rx.tap.bind { [weak self] in
            self?.tvTrigger.onNext(Void())
        }
        .disposed(by: disposeBag)
    }

}


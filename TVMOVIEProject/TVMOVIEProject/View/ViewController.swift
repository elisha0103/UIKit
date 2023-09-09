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
    let viewModel = ViewModel()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.id)
        collectionView.register(BigImageCollectionViewCell.self, forCellWithReuseIdentifier: BigImageCollectionViewCell.id)
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.id)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id) // Header 등록
        return collectionView
    }()
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // Subject - 이벤트를 발생 시키면서, 다른 곳에서 이벤트를 받을 수 있는 것
    // ButtonView에서 발생되는 이벤트를 구독하면서, ViewModel에 이벤트를 전달도 해야하기 때문에 Subject를 사용
    let tvTrigger = PublishSubject<Void>()
    let movieTrigger = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setDatasource()
    }

    private func configure() {
        configureUI()
        bindViewModel()
        bindView()
        tvTrigger.onNext(())
    }
    
    private func configureUI() {
        view.addSubview(buttonView)
        view.addSubview(collectionView)
        
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

        /**
         input으로 인해 데이터의 변경이 나타나면 transform 함수가 재호출되어 새로운 output이 할당되는 것이 아니다.
         각 함수의 반환값이 모두 Observable이다.
         따라서, 함수로 생성된 output도 Observable이고  output 안에 있는 각 프로퍼티도 모두 Observable이다.
         input에 의해 프로퍼티가 변경되면 해당 Observable 프로퍼티로 인해 output 안에 있는 프로퍼티까지 모두 Observable로 영향을 받기 때문에 결국, output 프로퍼티를 바인딩하면 데이터 변경의 알림이 나타난다.
         **/
        output.tvList.bind { tvList in
            print("tvList")
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            let items = tvList.map { Item.normal(Content(tv: $0)) }
            let section = Section.double
            snapshot.appendSections([section])
            snapshot.appendItems(items, toSection: section)
            self.dataSource?.apply(snapshot)
        }
        .disposed(by: disposeBag)
        
        output.movieResult.bind { [weak self] movieList in
            print("movieList")
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            let bigImageList = movieList.nowPlaying.results.map { Item.bigImage($0) }
            let bannerSection = Section.banner
            snapshot.appendSections([bannerSection])
            snapshot.appendItems(bigImageList, toSection: bannerSection)
            
            let horizontalSection = Section.horizontal("Popular Movies")
            let normalList = movieList.popular.results.map { Item.normal(Content(movie: $0)) }
            snapshot.appendSections([horizontalSection])
            snapshot.appendItems(normalList, toSection: horizontalSection)
            
            let verticalSection = Section.vertical("Upcoming Movies")
            let verticalList = movieList.upcoming.results.map { Item.list($0) }
            snapshot.appendSections([verticalSection])
            snapshot.appendItems(verticalList, toSection: verticalSection)
            
            self?.dataSource?.apply(snapshot)
        }
        .disposed(by: disposeBag)
    }
    
    private func bindView() {
        buttonView.tvButton.rx.tap.bind { [weak self] in
            self?.tvTrigger.onNext(Void())
        }
        .disposed(by: disposeBag)
        
        buttonView.movieButton.rx.tap.bind { [weak self] in
            self?.movieTrigger.onNext(Void())
        }
        .disposed(by: disposeBag)
    }

}


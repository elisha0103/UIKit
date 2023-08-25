//
//  ViewController.swift
//  ModernCollectionProject
//
//  Created by 진태영 on 2023/08/25.
//

import UIKit

class ViewController: UIViewController {
    let imageUrl = "https://static.onecms.io/wp-content/uploads/sites/43/2022/05/26/8805-CrispyFriedChicken-mfs-3x2-072.jpg"
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()

    }

    func configure() {
        configureUI()
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.register(NormalCaroselCollectionViewCell.self, forCellWithReuseIdentifier: NormalCaroselCollectionViewCell.id)
        collectionView.register(ListCarouselCollectionViewCell.self, forCellWithReuseIdentifier: ListCarouselCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        configureDataSource()
        configureSnapshot()
    }
    
    private func configureUI() {
        self.view.addSubview(collectionView)

        collectionView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([Section(id: "Banner")])
        let bannerItems = [
            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: imageUrl)),
            Item.banner(HomeItem(title: "굽네 치킨", imageUrl: imageUrl)),
            Item.banner(HomeItem(title: "푸라닭 치킨", imageUrl: imageUrl))
        ]
        snapshot.appendItems(bannerItems, toSection: Section(id: "Banner"))
        
        snapshot.appendSections([Section(id: "NormalCarosel")])
        let normalItem = [
            Item.normalCarousel(HomeItem(title: "교촌 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "굽네 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "푸라닭 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "후라이드 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "페리카나 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "BHC 치킨", imageUrl: imageUrl))
        ]
        snapshot.appendItems(normalItem, toSection: Section(id: "NormalCarosel"))
        
        snapshot.appendSections([Section(id: "ListCarosel")])
        let listItem = [
            Item.listCarousel(HomeItem(title: "교촌 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "굽네 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "푸라닭 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "후라이드 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "페리카나 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "BHC 치킨", imageUrl: imageUrl))
        ]
        snapshot.appendItems(listItem, toSection: Section(id: "ListCarosel"))
        
        dataSource?.apply(snapshot)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .banner(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
                
                cell.config(title: item.title, imageUrl: item.imageUrl)
                return cell
                
            case .normalCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCaroselCollectionViewCell.id, for: indexPath) as? NormalCaroselCollectionViewCell else { return UICollectionViewCell() }
                
                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
                
            case .listCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCarouselCollectionViewCell.id, for: indexPath) as? ListCarouselCollectionViewCell else { return UICollectionViewCell() }
                
                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
                
            default:
                return UICollectionViewCell()
            }
            
            
        })
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.createBannerSection()
            
            case 1:
                return self?.createNormalSection()
                
            case 2:
                return self?.createListSection()
                
            default:
                
                return self?.createBannerSection()

            }

        }, configuration: config) // Section간 간격
        
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        
        return section
    }
    
    private func createNormalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func createListSection() -> NSCollectionLayoutSection {
        let count = 3
        let itemFractionalHeight: CGFloat = CGFloat(1 / count)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(itemFractionalHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
        
    }
}

/*
 1. 컬렉션 뷰 cell UI 등록
 2. 레이아웃 구현 - 3가지 버전
 3. datasource -> cellProvider 전달
 4. snapshot 생성 -> datasorce.apply(snapshot)
 */

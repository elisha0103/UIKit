//
//  ViewContoller+.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/29.
//

import UIKit

// MARK: - Layout
extension ViewController {
    
    // collectionView 안에 구성되는 전체적인 Layout 구성 설정
    func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 14
        /*
        UICollectionViewCompositionalLayout(section: <#T##NSCollectionLayoutSection#>, configuration: <#T##UICollectionViewCompositionalLayoutConfiguration#>)
         section Layout 틀 설정, configuration: Layout 전체적인 디자인 속성 추가
         */
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .banner:
                return self?.createBannerSection()
            case .horizontal:
                return self?.createHorizontalSection()
            case .vertical:
                return self?.createListSection()
            default:
                return self?.createDoubleSection()
            }
        }, configuration: config)
    }
    
    // collectionView의 Layout 중 하나인 DoubleSection 구성 함수
    private func createDoubleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        let groupCount = 2
        let groupWidth: CGFloat = 1.0 / CGFloat(groupCount)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: groupCount)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(640))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // Header, Footer 설정
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    private func createListSection() -> NSCollectionLayoutSection {
        let count = 3
        let height: CGFloat = 1.0 / CGFloat(count)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: count)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

// MARK: - Datasource
extension ViewController {
    func setDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .normal(let content):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCollectionViewCell.id, for: indexPath) as? NormalCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(title: content.title, review: content.vote, description: content.overView, imageURL: content.posterURL)
                return cell
            case .bigImage(let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigImageCollectionViewCell.id, for: indexPath) as? BigImageCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(title: movie.title, overView: movie.overView, review: movie.vote, posterURL: movie.posterURL)
                return cell
            case .list(let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.id, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(title: movie.title, releaseDate: movie.releaseDate, imageURL: movie.posterURL)
                return cell
            }
            
        })
        
        // Header에 대한 dataSource 설정 추가
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath)
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .horizontal(let title), .vertical(let title):
                (header as? HeaderView)?.configure(title: title)
            default:
                print("Default")
            }
         return header
        }
    }
}

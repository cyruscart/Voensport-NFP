//
//  AboutAppCompositionalLayout.swift
//  Voensport-NFP
//
//  Created by Кирилл on 28.12.2021.
//

import UIKit

class AboutAppCompositionalLayout: UICollectionViewCompositionalLayout {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionKind = AboutAppSectionKind.allCases[sectionIndex]
            
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
            
            case .onboarding:
                let screenRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
                
                let totalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                           heightDimension: .fractionalHeight(1))

                let totalItem = NSCollectionLayoutItem(layoutSize: totalItemSize)
                let totalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.53),
                                                            heightDimension: .fractionalHeight(screenRatio))
                let totalGroup = NSCollectionLayoutGroup.vertical(layoutSize: totalGroupSize, subitems: [totalItem])
                
                totalGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
                let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                               heightDimension: .estimated(50))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                                elementKind: "AboutAppHeaderView",
                                                                                alignment: .top)
                
                section = NSCollectionLayoutSection(group: totalGroup)
                section.boundarySupplementaryItems = [sectionHeader]
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0 , bottom: 10, trailing: 0)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
            case .logo:
                
                let logoItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .fractionalHeight(1))
                let logoItem = NSCollectionLayoutItem(layoutSize: logoItemSize)
            
                let logoGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                               heightDimension: .fractionalWidth(0.8))
                let logoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: logoGroupSize, subitems: [logoItem])
                logoGroup.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                
                section = NSCollectionLayoutSection(group: logoGroup)
                section.orthogonalScrollingBehavior = .continuous
                
              
                let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                               heightDimension: .estimated(50))
                
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                                elementKind: "AboutAppHeaderView",
                                                                                alignment: .top)
                
                section.boundarySupplementaryItems = [sectionHeader]
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
                
            case .donate:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(200))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                               heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 50, trailing: 20)
            }
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        layout.configuration = config
        return layout
    }
}


//
//  ResultsCompositionalLayout.swift
//  Voensport-NFP
//
//  Created by Кирилл on 23.12.2021.
//

import UIKit

final class ResultsCompositionalLayout: UICollectionViewCompositionalLayout {
    static func createLayout(numberOfSection: Int) -> UICollectionViewCompositionalLayout {
        print("layout")
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionKind = Array(0...numberOfSection)[sectionIndex]
            let section: NSCollectionLayoutSection
            
            if sectionKind == numberOfSection  {
                let totalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                           heightDimension: .estimated(50))
                let totalItem = NSCollectionLayoutItem(layoutSize: totalItemSize)
                
                let totalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .estimated(50))
                let totalGroup = NSCollectionLayoutGroup.vertical(layoutSize: totalGroupSize, subitems: [totalItem])
                
                section = NSCollectionLayoutSection(group: totalGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 30, bottom: 40, trailing: 30)
            } else {
                let exerciseItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .estimated(50))
                let exerciseItem = NSCollectionLayoutItem(layoutSize: exerciseItemSize)
                
                let exerciseGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                               heightDimension: .estimated(50))
                let exerciseGroup = NSCollectionLayoutGroup.horizontal(layoutSize: exerciseGroupSize, subitem: exerciseItem, count: 1)
                
                section = NSCollectionLayoutSection(group: exerciseGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)
            }
            return section
        }
        return layout
    }
    
}

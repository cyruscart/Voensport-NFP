//
//  ResultsCompositionalLayout.swift
//  Voensport-NFP
//
//  Created by Кирилл on 23.12.2021.
//

import UIKit

class ResultsCompositionalLayout: UICollectionViewCompositionalLayout {
    static func createLayout(numberOfSection: Int) -> UICollectionViewCompositionalLayout {
        
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionKind = Array(0...numberOfSection)[sectionIndex]
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == numberOfSection  {

                let totalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                           heightDimension: .fractionalHeight(1))


                let totalItem = NSCollectionLayoutItem(layoutSize: totalItemSize)


                let totalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalWidth(0.55))

                let totalGroup = NSCollectionLayoutGroup.vertical(layoutSize: totalGroupSize, subitems: [totalItem])

                section = NSCollectionLayoutSection(group: totalGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 30, bottom: 40, trailing: 30)

            } else {
                
                let exerciseItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .fractionalHeight(1))
                
                
                let exerciseItem = NSCollectionLayoutItem(layoutSize: exerciseItemSize)
                exerciseItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let exerciseGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                               heightDimension: .fractionalWidth(0.4))
                let exerciseGroup = NSCollectionLayoutGroup.horizontal(layoutSize: exerciseGroupSize, subitems: [exerciseItem])
               
                section = NSCollectionLayoutSection(group: exerciseGroup)
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)
                  
            }
                
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        layout.configuration = config
        return layout
    }
}

//
//  NfpCompositionalLayout.swift
//  Voensport-NFP
//
//  Created by Кирилл on 09.12.2021.
//

import Foundation
import UIKit

class NfpCompositionalLayout: UICollectionViewCompositionalLayout {
    static func createLayout(settings: Settings) -> UICollectionViewCompositionalLayout {
        
        let numberOfSections = settings.getIntegerNumberOfExercises() + 1
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionKind = Array(0..<numberOfSections)[sectionIndex]
            
            let section: NSCollectionLayoutSection
            
//            if sectionKind == numberOfSections - 1  {
//
//                let totalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                           heightDimension: .fractionalHeight(1))
//
//
//                let totalItem = NSCollectionLayoutItem(layoutSize: totalItemSize)
//
//
//                let totalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                            heightDimension: .fractionalHeight(0.2))
//
//                let totalGroup = NSCollectionLayoutGroup.vertical(layoutSize: totalGroupSize, subitems: [totalItem])
//
//                section = NSCollectionLayoutSection(group: totalGroup)
//                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//
//            } else {
                let exerciseItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .fractionalHeight(1))
                
                
                let exerciseItem = NSCollectionLayoutItem(layoutSize: exerciseItemSize)
                exerciseItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let exerciseGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                               heightDimension: .fractionalHeight(0.3))
                let exerciseGroup = NSCollectionLayoutGroup.horizontal(layoutSize: exerciseGroupSize, subitems: [exerciseItem])
                exerciseGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                section = NSCollectionLayoutSection(group: exerciseGroup)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                               heightDimension: .fractionalHeight(0.1))
                
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionFooterSize,
                                                                                elementKind: "Footer",
                                                                                alignment: .bottom)
              
                sectionFooter.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [sectionFooter]
                
//            }
            
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        layout.configuration = config
        return layout
    }
}

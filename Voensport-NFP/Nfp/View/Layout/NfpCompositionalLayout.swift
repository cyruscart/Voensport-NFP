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
        
        let numberOfSections = settings.getIntegerNumberOfExercises()
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionKind = Array(0...numberOfSections)[sectionIndex]
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == numberOfSections  {

                let totalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                           heightDimension: .fractionalHeight(1))


                let totalItem = NSCollectionLayoutItem(layoutSize: totalItemSize)


                let totalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.2))

                let totalGroup = NSCollectionLayoutGroup.vertical(layoutSize: totalGroupSize, subitems: [totalItem])

                section = NSCollectionLayoutSection(group: totalGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

            } else {
                
                let exerciseItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .fractionalHeight(1))
                
                
                let exerciseItem = NSCollectionLayoutItem(layoutSize: exerciseItemSize)
                exerciseItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let exerciseGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                               heightDimension: .fractionalHeight(0.25))
                let exerciseGroup = NSCollectionLayoutGroup.horizontal(layoutSize: exerciseGroupSize, subitems: [exerciseItem])
                exerciseGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                
                section = NSCollectionLayoutSection(group: exerciseGroup)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                               heightDimension: .fractionalHeight(0.13))
                
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionFooterSize,
                                                                                elementKind: "Footer",
                                                                                alignment: .bottom)
              
                sectionFooter.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [sectionFooter]
                section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0)
            
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2)
                    let minScale: CGFloat = 1
                    let maxScale: CGFloat = 1.12
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
            }
                
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        layout.configuration = config
        return layout
    }
}


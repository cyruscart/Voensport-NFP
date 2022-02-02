//
//  NfpCompositionalLayout.swift
//  Voensport-NFP
//
//  Created by Кирилл on 09.12.2021.
//


import UIKit

class NfpCompositionalLayout  {
    
     static func createLayout(numberOfSections: Int) -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let sectionKind = Array(0...numberOfSections)[sectionIndex]
            
            return sectionKind == numberOfSections
            ? self.createTotalScoreSection()
            : self.createExerciseSection()
            
        }
        return layout
    }
    
    static private func createTotalScoreSection() -> NSCollectionLayoutSection {
        let totalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1))
        let totalItem = NSCollectionLayoutItem(layoutSize: totalItemSize)
        
        let totalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .fractionalWidth(0.5))
        let totalGroup = NSCollectionLayoutGroup.vertical(layoutSize: totalGroupSize, subitems: [totalItem])
        
        let section = NSCollectionLayoutSection(group: totalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 30, bottom: 40, trailing: 30)
        
        return section
    }
    
    static private func createExerciseSection() -> NSCollectionLayoutSection {
        let exerciseItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
        let exerciseItem = NSCollectionLayoutItem(layoutSize: exerciseItemSize)
        exerciseItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let exerciseGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                       heightDimension: .fractionalWidth(0.45))
        let exerciseGroup = NSCollectionLayoutGroup.horizontal(layoutSize: exerciseGroupSize, subitems: [exerciseItem])
        exerciseGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: exerciseGroup)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                       heightDimension: .fractionalWidth(0.27))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionFooterSize,
                                                                        elementKind: "Footer",
                                                                        alignment: .bottom)
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                       heightDimension: .fractionalWidth(0.12))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: "Header",
                                                                        alignment: .top)
        
        sectionFooter.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2)
                let minScale: CGFloat = 1
                let maxScale: CGFloat = 1.10
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return section
    }
}



//
//  OnboardingCompositionalLayout.swift
//  Voensport-NFP
//
//  Created by Кирилл on 29.12.2021.
//

import UIKit

class OnboardingCompositionalLayout: UICollectionViewCompositionalLayout {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let totalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(1))
            
            let totalItem = NSCollectionLayoutItem(layoutSize: totalItemSize)
            let totalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(0.46),
                                                        heightDimension: .fractionalHeight(0.75))
            
            let totalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: totalGroupSize, subitems: [totalItem])
            
            totalGroup.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 40, bottom: 0, trailing: 40)
            
            let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                           heightDimension: .estimated(100))
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionFooterSize,
                                                                            elementKind: "OnBoardingFooter",
                                                                            alignment: .bottom)
            
            let section = NSCollectionLayoutSection(group: totalGroup)
            section.boundarySupplementaryItems = [sectionFooter]
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
           
            return section
        }
        
        return layout
    }
}



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
            let totalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                        heightDimension: .fractionalHeight(0.87))
            
            let totalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: totalGroupSize, subitems: [totalItem])
            
            totalGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                           heightDimension: .absolute(40))
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionFooterSize,
                                                                            elementKind: "OnBoardingFooter",
                                                                            alignment: .bottom)
            
            let section = NSCollectionLayoutSection(group: totalGroup)
            section.boundarySupplementaryItems = [sectionFooter]
            //                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0 , bottom: 10, trailing: 0)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
           
            return section
        }
        
        
        return layout
    }
}



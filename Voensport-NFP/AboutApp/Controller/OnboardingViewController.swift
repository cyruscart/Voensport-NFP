//
//  OnboardingViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 26.12.2021.
//

import UIKit


class OnboardingViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var visibleItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: OnboardingCompositionalLayout.createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        
        collectionView.register(OnBoardingFooter.self, forSupplementaryViewOfKind: "OnBoardingFooter", withReuseIdentifier: OnBoardingFooter.identifier)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
    }
    
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        OnboardingItem.generateItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
            cell.configure(OnboardingItem.generateItems()[indexPath.item])
            return cell

        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: "OnBoardingFooter", withReuseIdentifier: OnBoardingFooter.identifier, for: indexPath) as! OnBoardingFooter
        view.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            return view
    }
    
    @objc private func nextButtonTapped() {
        visibleItem += 1
        if visibleItem < OnboardingItem.generateItems().count {
            let indexPath = IndexPath(item: visibleItem, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}


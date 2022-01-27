//
//  OnboardingViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 26.12.2021.
//

import UIKit

final class OnboardingViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: OnboardingCompositionalLayout.createLayout())
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        collectionView.register(OnBoardingFooter.self, forSupplementaryViewOfKind: "OnBoardingFooter", withReuseIdentifier: OnBoardingFooter.identifier)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
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
        view.configure(OnboardingItem.generateItems()[indexPath.item])
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let visibleItemIndex = collectionView.indexPathsForVisibleItems.first?.item else { return }
        updateSupplementaryView(itemIndex: visibleItemIndex)
        setButtonTitle(index: visibleItemIndex)
    }
    
    @objc private func nextButtonTapped() {
        guard let visibleItemIndex = collectionView.indexPathsForVisibleItems.first?.item else { return }
        let nextVisibleItemIndex = visibleItemIndex + 1
        
        if nextVisibleItemIndex < OnboardingItem.generateItems().count {
            let indexPath = IndexPath(item: nextVisibleItemIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            setButtonTitle(index: nextVisibleItemIndex)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateSupplementaryView(itemIndex: Int) {
        guard let footer = collectionView.visibleSupplementaryViews(ofKind: "OnBoardingFooter").first as? OnBoardingFooter else { return }
        footer.configure(OnboardingItem.generateItems()[itemIndex])
    }
    
    private func setButtonTitle(index: Int) {
        guard let footer = collectionView.visibleSupplementaryViews(ofKind: "OnBoardingFooter").first as? OnBoardingFooter else { return }
        let title = index == OnboardingItem.generateItems().count - 1 ? "Закрыть" : "Далее"
        footer.nextButton.setTitle(title, for: .normal)
    }
    
}


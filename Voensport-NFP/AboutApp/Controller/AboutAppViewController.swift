//
//  AboutAppViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 26.12.2021.
//

import UIKit
import PassKit

enum AboutAppSectionKind: CaseIterable  {
    case onboarding
    case logo
    
    static let logoImagesName = ["logo5", "logo2", "logo3", "logo4", "logo1", "logo6", "logo7", "logo8"]
}

final class AboutAppViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: AboutAppCompositionalLayout.createLayout())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AboutImageCell.self, forCellWithReuseIdentifier: AboutImageCell.identifier)
        collectionView.register(AboutAppHeaderView.self, forSupplementaryViewOfKind: "AboutAppHeaderView", withReuseIdentifier: AboutAppHeaderView.identifier)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "О приложении"
    }
    
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension AboutAppViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        AboutAppSectionKind.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        AboutAppSectionKind.allCases[section] == .logo ? AboutAppSectionKind.logoImagesName.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch AboutAppSectionKind.allCases[indexPath.section] {
            
        case .onboarding:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutImageCell.identifier, for: indexPath) as! AboutImageCell
            cell.showLogo(images: 50)
            return cell
            
        case .logo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutImageCell.identifier, for: indexPath) as! AboutImageCell
            cell.configureCell(imageName: AboutAppSectionKind.logoImagesName[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: "AboutAppHeaderView", withReuseIdentifier: AboutAppHeaderView.identifier, for: indexPath) as! AboutAppHeaderView
        view.headingLabel.text = ["Возможности", "Логотип"][indexPath.section]
        view.messageLabel.text = ["", "Вы могли заметить, какой необычный логотип у этого приложения. Он был сгенерирован нейросетью ruDALL-E по текстовому запросу. Посмотрите, какие еще крутые варианты она нарисовала"][indexPath.section]
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let onboardingVC = OnboardingViewController()
            onboardingVC.modalPresentationStyle = .fullScreen
            present(onboardingVC, animated: true, completion: nil)
        }
    }
    
}

//
//  AboutAppViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 26.12.2021.
//

import UIKit

enum AboutAppSectionKind: CaseIterable  {
    case onboarding
    case logo
    case donate
}

class AboutAppViewController: UIViewController {
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: AboutAppCompositionalLayout.createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AboutImageCell.self, forCellWithReuseIdentifier: AboutImageCell.identifier)
        collectionView.register(DonateCell.self, forCellWithReuseIdentifier: DonateCell.identifier)
        collectionView.register(AboutAppHeaderView.self, forSupplementaryViewOfKind: "AboutAppHeaderView", withReuseIdentifier: AboutAppHeaderView.identifier)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "О приложении"
    }
    
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension AboutAppViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch AboutAppSectionKind.allCases[section] {
        case .onboarding:
            return 1
        case .logo:
            return LogoImagePresentation.imagesName.count
        case .donate:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch AboutAppSectionKind.allCases[indexPath.section] {
        case .onboarding:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutImageCell.identifier, for: indexPath) as! AboutImageCell
            cell.showLogo(images: 173)
            
            return cell
            
        case .logo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutImageCell.identifier, for: indexPath) as! AboutImageCell
            cell.configureCell(imageName: LogoImagePresentation.imagesName[indexPath.item])
            return cell
            
        case .donate:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DonateCell.identifier, for: indexPath) as! DonateCell
            cell.messageLabel.text = """
            Если Вам нравится это приложение,
            Вы можете поблагодарить разработчика
            """
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: "AboutAppHeaderView", withReuseIdentifier: AboutAppHeaderView.identifier, for: indexPath) as! AboutAppHeaderView
            view.headingLabel.text = ["Возможности", "Логотип"][indexPath.section]
            view.messageLabel.text = ["", "Логотип для этого приложения был сгенерирован нейросетью ruDALL-E, просто посмотрите, какие еще крутые варианты она предложила"][indexPath.section]
            return view
    }
}



//
//  NfpViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class NfpViewController: UIViewController  {
    
    var settings: Settings! = nil
    var nfpPerformance: NfpPerformance! = nil
    
    var collectionView: UICollectionView! = nil
    
    var exerciseDataSource: UICollectionViewDiffableDataSource<Int, NfpExercise>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nfpPerformance = NfpPerformance(settings: settings)
        setupCollectionView()
        configureDataSource()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        applyInitialSnapshots()
        
       
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: NfpCompositionalLayout.createLayout(settings: settings))
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сдача ФП"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(showSettings)
        )
    }
    
    
    
    @objc private func showSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.settings = settings
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

// MARK: UICollectionViewDiffableDataSource
extension NfpViewController {
    
    private func configureDataSource() {
        
        let exerciseCellRegistration = UICollectionView.CellRegistration<ExerciseCell, NfpExercise> { (cell, indexPath, exercise) in
            cell.configureCell(with: exercise)
            cell.layer.cornerRadius = 15
        }
        
//        let totalScoreCellRegistration = UICollectionView.CellRegistration<TotalScoreCell, NfpPerformance> { (cell, indexPath, nfpPerformance) in
//            cell.configureCell(with: nfpPerformance)
//        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<ResultCellView >(elementKind: "Footer") { view, elementKind, indexPath in
            
            
                  
        }
        
        exerciseDataSource = UICollectionViewDiffableDataSource <Int, NfpExercise>(collectionView: collectionView) {
            (collectionView, indexPath, exercise) -> UICollectionViewCell? in
            
            print(indexPath.section)
            return collectionView.dequeueConfiguredReusableCell(using: exerciseCellRegistration, for: indexPath, item: exercise)

        }
        
        exerciseDataSource.supplementaryViewProvider = { view, kind, index in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        applyInitialSnapshots()
        
    }
    
    private func applyInitialSnapshots() {
        var exerciseSnapshot = NSDiffableDataSourceSnapshot<Int, NfpExercise>()

        for numberOfSection in 0..<settings.getIntegerNumberOfExercises() {
            exerciseSnapshot.appendSections([numberOfSection])
            exerciseSnapshot.appendItems(nfpPerformance.exercises[numberOfSection], toSection: numberOfSection)
        }
        
        exerciseDataSource.apply(exerciseSnapshot)
        
    }
    
    
}


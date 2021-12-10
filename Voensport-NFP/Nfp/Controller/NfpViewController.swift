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
    var isAppear = false
    var collectionView: UICollectionView! = nil
    
    var exerciseDataSource: UICollectionViewDiffableDataSource<Int, NfpExercise>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nfpPerformance = NfpPerformance(settings: settings)
        nfpPerformance.loadInitialData()
        setupCollectionView()
        
        configureDataSource()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isAppear = true
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: NfpCompositionalLayout.createLayout(settings: settings))
        collectionView.delegate = self
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
    

    @objc private func s1howSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.settings = settings
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc private func showSettings() {
        print(nfpPerformance.selectedExercises.first?.number)
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
            let exercise = self.nfpPerformance.exercises[indexPath.section][indexPath.row]
            view.minimumScore = self.nfpPerformance.getMinimumScore(indexPath: indexPath)
            view.exercise = exercise
            view.configureCell()
            view.setSliderTrackColor()
                  
        }
        
        exerciseDataSource = UICollectionViewDiffableDataSource <Int, NfpExercise>(collectionView: collectionView) {
            (collectionView, indexPath, exercise) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: exerciseCellRegistration, for: indexPath, item: exercise)

        }
        
        
        exerciseDataSource.supplementaryViewProvider = { [self] view, kind, index in
            return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        applyInitialSnapshots()
        
    }

    private func testCompletion() {
        navigationController?.navigationBar.isHidden.toggle()
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

extension NfpViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        if indexPath.item == 0 {
//
//
//        } else if indexPath.item == nfpPerformance.exercises[indexPath.section].count - 1 {
//            nfpPerformance.selectedExercises[indexPath.section] = nfpPerformance.exercises[indexPath.section][indexPath.item]
//
//        } else {
//
//
//        }
        if isAppear {
        nfpPerformance.selectedExercises[indexPath.section] = nfpPerformance.exercises[indexPath.section][indexPath.item - 1]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
     
    }
}


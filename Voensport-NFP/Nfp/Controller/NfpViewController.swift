//
//  NfpViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit



class NfpViewController: UIViewController  {
    
    var settings: Settings!
    var nfpPerformance: NfpPerformance!
    var isAppear = false
    
    var collectionView: UICollectionView!
   
    
    
    var exerciseDataSource: UICollectionViewDiffableDataSource<Int, NfpExercise>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        nfpPerformance = NfpPerformance(settings: settings)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nfpPerformance.loadInitialData()
        updateCompositionalLayout()
       
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isAppear = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        isAppear = false
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: NfpCompositionalLayout.createLayout(settings: settings))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: ExerciseCell.identifier)
        collectionView.register(TotalScoreCell.self, forCellWithReuseIdentifier: TotalScoreCell.identifier)
        collectionView.register(ResultCellView.self, forSupplementaryViewOfKind: "Footer", withReuseIdentifier: ResultCellView.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.identifier)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func updateCompositionalLayout() {
        let layout = NfpCompositionalLayout.createLayout(settings: settings)
        collectionView.setCollectionViewLayout(layout, animated: false)
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
    
    private func updateTotalScoreCell() {
        collectionView.visibleCells.forEach { cell in
            if let totalCell = cell as? TotalScoreCell {
                totalCell.configureCell(with: nfpPerformance)
            }
        }
    }
    
}

extension NfpViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        settings.getIntegerNumberOfExercises() + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == settings.getIntegerNumberOfExercises() {
            return 1
        } else {
            return nfpPerformance.exercises[section].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == settings.getIntegerNumberOfExercises() {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalScoreCell.identifier, for: indexPath) as! TotalScoreCell
            cell.configureCell(with: self.nfpPerformance)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCell.identifier, for: indexPath) as! ExerciseCell
            cell.configureCell(with: nfpPerformance.exercises[indexPath.section][indexPath.row])
            cell.layer.cornerRadius = 15
            return cell
        }
            
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Footer" {
            let exercise = self.nfpPerformance.selectedExercises[indexPath.section]
            let minimumScore = self.nfpPerformance.getMinimumScore(for: exercise)
            
            if exercise.score == 0 {
                exercise.score = minimumScore
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: "Footer", withReuseIdentifier: ResultCellView.identifier, for: indexPath) as! ResultCellView
            
            view.minimumScore = minimumScore
            view.exercise = exercise
            view.section = indexPath.section
            view.configureCell()
            
            view.completion = { [unowned self] in
                updateTotalScoreCell()
            }
            
            return view
            
        } else {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
            view.label.text = "\(indexPath.section + 1)  упражнение"
            return view
        
    }
    
}
}

extension NfpViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let shouldReplaceSelectedItem = isAppear && !collectionView.isDragging && !collectionView.isTracking && !collectionView.isDecelerating
        
        if shouldReplaceSelectedItem {
            updateSelectedExercises(collectionView, forItemAt: indexPath)
            updateSupplementaryView(collectionView, indexPath: indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let shouldReplaceSelectedItem = isAppear && !collectionView.isDragging && !collectionView.isTracking && !collectionView.isDecelerating
        
        if shouldReplaceSelectedItem {
            if indexPath.row == 2 {
                nfpPerformance.selectedExercises[indexPath.section] = nfpPerformance.exercises[indexPath.section][0]
            } else if indexPath.row == nfpPerformance.exercises[indexPath.section].count - 3 {
                nfpPerformance.selectedExercises[indexPath.section] = nfpPerformance.exercises[indexPath.section][nfpPerformance.exercises[indexPath.section].count - 1]
            }
            
        }
    }
    
    private func updateSupplementaryView(_ collectionView: UICollectionView, indexPath: IndexPath) {
        
        collectionView.visibleSupplementaryViews(ofKind: "Footer").forEach { supplView in
            let view = supplView as! ResultCellView
            
            if view.section == indexPath.section {
            
            let exercise = self.nfpPerformance.selectedExercises[indexPath.section]
            let minimumScore = self.nfpPerformance.getMinimumScore(for: exercise)
            exercise.score = minimumScore
                
            view.minimumScore = minimumScore
            view.exercise = exercise
            view.configureCell()
            }
        }
            
        }
      
    
   
    
    private func updateSelectedExercises(_ collectionView: UICollectionView, forItemAt indexPath: IndexPath) {
        
        /* current item - 2
         
         slide to left, next item - 1
         [[0, 1], [0, 2]]         - visible
         [0, 0]                   - will display
         
         slide to right, next item - 3
         [[0, 2], [0, 3]]          - visible
         [0, 4]                    - will display
         
         */
        
        let visibleItemsInSection = collectionView
            .indexPathsForVisibleItems
            .filter {$0.section == indexPath.section}
            .sorted {$0.row < $1.row}
        
        if visibleItemsInSection.count == 2 {
            let indexPathNextSelectedItem = visibleItemsInSection[1].row > indexPath.row ?
            visibleItemsInSection[0] :
            visibleItemsInSection[1]
            
            // Replace selected item to a new one
            nfpPerformance.selectedExercises[indexPath.section] = nfpPerformance.exercises[indexPathNextSelectedItem.section][indexPathNextSelectedItem.row]
        }
        
        
    }
}



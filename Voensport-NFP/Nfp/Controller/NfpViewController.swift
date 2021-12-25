//
//  NfpViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class NfpViewController: UIViewController  {
    
    var updateUIAfterEditingDelegate: UpdateUIAfterEditingDelegate?
    var nfpController: NfpController!
    var shouldObserveVisibleCells = false
    var collectionView: UICollectionView!
    private var feedbackGenerator: UISelectionFeedbackGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        nfpController.loadInitialData()
        updateCompositionalLayout()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top , animated: false)
        collectionView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        shouldObserveVisibleCells = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        shouldObserveVisibleCells = false
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: NfpCompositionalLayout.createLayout(numberOfSections: nfpController.settings.getIntegerNumberOfExercises()))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: ExerciseCell.identifier)
        collectionView.register(TotalScoreCell.self, forCellWithReuseIdentifier: TotalScoreCell.identifier)
        collectionView.register(ResultCellView.self, forSupplementaryViewOfKind: "Footer", withReuseIdentifier: ResultCellView.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.identifier)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func updateCompositionalLayout() {
        let layout = NfpCompositionalLayout.createLayout(numberOfSections: nfpController.settings.getIntegerNumberOfExercises())
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = nfpController.isEditing
        ? nfpController.editingResultDate
        : "Сдача ФП"
        
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(showSettings))
        
        let closeAction = UIAction { [ unowned self ] _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let closeButton = UIBarButtonItem(systemItem: .close, primaryAction: closeAction, menu: nil)
        
        navigationItem.rightBarButtonItem = nfpController.isEditing
        ? closeButton
        : settingsButton
    }
    
    private func startFeedbackGenerator() {
        
        if nfpController.settings.hapticOn {
            feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator?.prepare()
            feedbackGenerator?.selectionChanged()
            feedbackGenerator = nil
        }
    }
    
    private func saveResults() {
        let nfpResult = nfpController.generateNfpResult()
        
        if nfpController.isEditing {
            StorageManager.shared.editNfpResult(with: nfpController.editingResultIndex, and: nfpResult)
            updateUIAfterEditingDelegate?.updateUI(indexPath: nfpController.editingResultIndex)
            dismiss(animated: true)
        } else {
            var resultsController = StorageManager.shared.getResults()
            resultsController.nfpResults.insert(nfpResult, at: 0)
            StorageManager.shared.saveResults(results: resultsController)
        }
    }
    
    //MARK: - Update UI
    
    private func updateTotalScoreCell() {
        collectionView.visibleCells.forEach { cell in
            if let totalCell = cell as? TotalScoreCell {
                totalCell.configureCell(with: nfpController)
                totalCell.moneyButton.alpha = nfpController.shouldShowMoneyButton() ? 1 : 0.4
                
            }
        }
    }
    
    private func updateSupplementaryView(_ collectionView: UICollectionView, indexPath: IndexPath) {
        
        collectionView.visibleSupplementaryViews(ofKind: "Footer").forEach { supplView in
            let view = supplView as! ResultCellView
            
            if view.tag == indexPath.section {
                
                let exercise = self.nfpController.selectedExercises[indexPath.section]
                let minimumScore = self.nfpController.getMinimumScore(for: exercise)
                exercise.score = minimumScore
                
                view.minimumScore = minimumScore
                view.exercise = exercise
                view.configureCell()
            }
        }
        
        collectionView.visibleSupplementaryViews(ofKind: "Header").forEach { supplView in
            let view = supplView as! HeaderView
            
            if view.tag == indexPath.section {
                let type = nfpController.selectedExercises[indexPath.section].type.rawValue
                view.label.text = "\(type)"
                
            }
        }
        
        updateTotalScoreCell()
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
            
            nfpController.selectedExercises[indexPath.section] = nfpController.exercises[indexPathNextSelectedItem.section][indexPathNextSelectedItem.row]
        }
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension NfpViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        nfpController.settings.getIntegerNumberOfExercises() + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == nfpController.settings.getIntegerNumberOfExercises() {
            return 1
        } else {
            return nfpController.exercises[section].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == nfpController.settings.getIntegerNumberOfExercises() {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalScoreCell.identifier, for: indexPath) as! TotalScoreCell
            cell.configureCell(with: self.nfpController)
            cell.moneyButton.alpha = nfpController.shouldShowMoneyButton() ? 1 : 0.4
            cell.moneyButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            cell.saveButtonCallBack = { [unowned self] in
                self.saveResults()
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCell.identifier, for: indexPath) as! ExerciseCell
            cell.exercise = nfpController.exercises[indexPath.section][indexPath.row]
            cell.configureCell()
            
            cell.callback = { [unowned self] exercise in
                self.showDescription(with: exercise)
            }
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Footer" {
            let exercise = self.nfpController.selectedExercises[indexPath.section]
            let minimumScore = self.nfpController.getMinimumScore(for: exercise)
            
            if exercise.score == 0 {
                exercise.score = minimumScore
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: "Footer", withReuseIdentifier: ResultCellView.identifier, for: indexPath) as! ResultCellView
            
            view.minimumScore = minimumScore
            view.exercise = exercise
            view.tag = indexPath.section
            view.configureCell()
            
            view.callback = { [unowned self] in
                startFeedbackGenerator()
                updateTotalScoreCell()
            }
            
            return view
            
        } else {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
            let type = nfpController.selectedExercises[indexPath.section].type.rawValue
            view.label.text = "\(type)"
            view.tag = indexPath.section
            return view
            
        }
    }
    
}

//MARK: - UICollectionViewDelegate

extension NfpViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let shouldReplaceSelectedItem = shouldObserveVisibleCells && !collectionView.isDragging && !collectionView.isTracking && !collectionView.isDecelerating
        
        if shouldReplaceSelectedItem {
            updateSelectedExercises(collectionView, forItemAt: indexPath)
            updateSupplementaryView(collectionView, indexPath: indexPath)
        }
        
        guard let totalCell = cell as? TotalScoreCell else { return }
        totalCell.configureCell(with: nfpController)
        totalCell.moneyButton.alpha = nfpController.shouldShowMoneyButton() ? 1 : 0.4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //        Scroll right
        //                [1, 2]             - didEndDisplaying cell
        //                [[1, 3], [1, 4]]   - sorted visible cells
        
        //        Scroll left
        //               [1, 2]              - didEndDisplaying cell
        //               [[1, 0], [1, 1]]    - sorted visible cells
        
        
        let sortedIndexPathForVisibleItems = collectionView.indexPathsForVisibleItems.filter {$0.section == indexPath.section}
            .sorted {$0.row < $1.row}
        
        let isCellScrollToLeft = indexPath.row > sortedIndexPathForVisibleItems.first?.row ?? 0
        let isDidEndDisplayingTotalScoreCell = indexPath.section == nfpController.settings.getIntegerNumberOfExercises()
        
        let shouldReplaceSelectedItem = shouldObserveVisibleCells && !collectionView.isDragging && !collectionView.isTracking && !collectionView.isDecelerating && !isDidEndDisplayingTotalScoreCell
        
        if shouldReplaceSelectedItem {
            
            if indexPath.row == 2 && isCellScrollToLeft {
                
                nfpController.selectedExercises[indexPath.section] = nfpController.exercises[indexPath.section][0]
                updateSupplementaryView(collectionView, indexPath: indexPath)
            } else if indexPath.row == nfpController.exercises[indexPath.section].count - 3 && !isCellScrollToLeft{
                nfpController.selectedExercises[indexPath.section] = nfpController.exercises[indexPath.section][nfpController.exercises[indexPath.section].count - 1]
                updateSupplementaryView(collectionView, indexPath: indexPath)
            }
        }
    }
    
}

//MARK: - Navigation

extension NfpViewController {
    
    @objc private func showSettings() {
        shouldObserveVisibleCells = false
        let settingsVC = SettingsViewController()
        settingsVC.settings = nfpController.settings
        navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    
    private func showDescription(with exercise: NfpExercise) {
        let descriptionVC = ExerciseDescriptionViewController()
        descriptionVC.configure(with: exercise)
        
        present(descriptionVC, animated: true)
        
    }
    
    
    @objc private func showAlert() {
        if nfpController.shouldShowMoneyButton() {
            nfpController.settings.tariff == 0
            ? showSettingsAlert()
            : showMoneyAlert()
            
        }
    }
    
    private func showSettingsAlert() {
        let alert = UIAlertController.createSettingsAlertController()
        
        alert.setSettingsAction { [unowned self] tariff, sportGrade in
            self.nfpController.settings.tariff = tariff
            self.nfpController.settings.sportGrade = sportGrade
            showMoneyAlert()
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func showMoneyAlert() {
        let alert = UIAlertController.createMoneyAlertController(money: nfpController.getAmountOfMoney())
        present(alert, animated: true, completion: nil)
    }
}


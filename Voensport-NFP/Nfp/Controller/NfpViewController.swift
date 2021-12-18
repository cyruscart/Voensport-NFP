//
//  NfpViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit



class NfpViewController: UIViewController  {
    
    var settings: Settings!
    var nfpPerformance: NfpController!
    var isAppear = false
    var exerciseDataSource: UICollectionViewDiffableDataSource<Int, NfpExercise>!
    var collectionView: UICollectionView!
    private var feedbackGenerator: UISelectionFeedbackGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        nfpPerformance = NfpController(settings: settings)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        nfpPerformance.loadInitialData()
        updateCompositionalLayout()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        
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
    
    private func startFeedbackGenerator() {
        
        if settings.hapticOn {
            feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator?.prepare()
            feedbackGenerator?.selectionChanged()
            feedbackGenerator = nil
        }
    }
    
    //MARK: - Update UI
    
    private func updateTotalScoreCell() {
        collectionView.visibleCells.forEach { cell in
            if let totalCell = cell as? TotalScoreCell {
                totalCell.configureCell(with: nfpPerformance)
            }
        }
    }
    
    private func updateSupplementaryView(_ collectionView: UICollectionView, indexPath: IndexPath) {
        
        collectionView.visibleSupplementaryViews(ofKind: "Footer").forEach { supplView in
            let view = supplView as! ResultCellView
            
            if view.tag == indexPath.section {
                
                let exercise = self.nfpPerformance.selectedExercises[indexPath.section]
                let minimumScore = self.nfpPerformance.getMinimumScore(for: exercise)
                exercise.score = minimumScore
                
                view.minimumScore = minimumScore
                view.exercise = exercise
                view.configureCell()
            }
        }
        
        collectionView.visibleSupplementaryViews(ofKind: "Header").forEach { supplView in
            let view = supplView as! HeaderView
            
            if view.tag == indexPath.section {
                let type = nfpPerformance.selectedExercises[indexPath.section].type.rawValue
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
            
            nfpPerformance.selectedExercises[indexPath.section] = nfpPerformance.exercises[indexPathNextSelectedItem.section][indexPathNextSelectedItem.row]
        }
        
    }
    
}

//MARK: - UICollectionViewDataSource

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
            cell.moneyButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCell.identifier, for: indexPath) as! ExerciseCell
            cell.exercise = nfpPerformance.exercises[indexPath.section][indexPath.row]
            cell.configureCell()
            
            cell.callback = { [unowned self] exercise in
                self.showDescription(with: exercise)
            }
            
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
            view.tag = indexPath.section
            view.configureCell()
            
            view.callback = { [unowned self] in
                startFeedbackGenerator()
                updateTotalScoreCell()
            }
            
            return view
            
        } else {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
            let type = nfpPerformance.selectedExercises[indexPath.section].type.rawValue
            view.label.text = "\(type)"
            view.tag = indexPath.section
            return view
            
        }
    }
    
}

//MARK: - UICollectionViewDelegate

extension NfpViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let shouldReplaceSelectedItem = isAppear && !collectionView.isDragging && !collectionView.isTracking && !collectionView.isDecelerating
        
        if shouldReplaceSelectedItem {
            updateSelectedExercises(collectionView, forItemAt: indexPath)
            updateSupplementaryView(collectionView, indexPath: indexPath)
        }
        
        guard let totalCell = cell as? TotalScoreCell else { return }
        totalCell.configureCell(with: nfpPerformance)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let shouldReplaceSelectedItem = isAppear && !collectionView.isDragging && !collectionView.isTracking && !collectionView.isDecelerating
        
        if shouldReplaceSelectedItem {
            
            if indexPath.row == 2 {
                nfpPerformance.selectedExercises[indexPath.section] = nfpPerformance.exercises[indexPath.section][0]
                updateSupplementaryView(collectionView, indexPath: indexPath)
            } else if indexPath.row == nfpPerformance.exercises[indexPath.section].count - 3 {
                nfpPerformance.selectedExercises[indexPath.section] = nfpPerformance.exercises[indexPath.section][nfpPerformance.exercises[indexPath.section].count - 1]
                updateSupplementaryView(collectionView, indexPath: indexPath)
            }
        }
    }
    
}

//MARK: - Navigation

extension NfpViewController {
    
    @objc private func showSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.settings = settings
        navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    
    private func showDescription(with exercise: NfpExercise) {
        let descriptionVC = ExerciseDescriptionViewController()
        descriptionVC.configure(with: exercise)
        
        present(descriptionVC, animated: true)
        
    }
    
    @objc private func showAlert() {
        
        let title = settings.tariff == 0
        ? "Недостаточно данных!"
        : "\(nfpPerformance.getAmountOfMoney()) \u{20BD}"
        
        let message = settings.tariff == 0
        ? "Для расчета надбавки за ФП перейдите в настройки и выберите свой тарифный разряд"
        : "составит ежемесячная надбавка к денежному довольствию (после вычета налогов)"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        
        let closeAction = UIAlertAction(title: "Понятно", style: .cancel)
        let showSettingsAction = UIAlertAction(title: "В настройки", style: .default) {_ in
            self.showSettings()
        }
        
        if settings.tariff == 0 {
            alert.addAction(showSettingsAction)
            alert.addAction(closeAction)
        } else {
            alert.addAction(closeAction)
        }
        
        present(alert, animated: true)
    }
}

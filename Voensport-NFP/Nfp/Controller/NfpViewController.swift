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
    private var exercises: [[NfpExercise]]!
    
    private var tableView: UITableView!
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nfpPerformance = NfpPerformance(settings: settings)
        collectionView = UICollectionView()
        setTableView()
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        exercises = nfpPerformance.getExercises()
    }
    
    private func setupNavigationBar() {
        title = "Сдача ФП"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(showSettings)
        )
    }
    
    private func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
       
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func showSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.settings = settings
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension NfpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        NfpPerformance.shared.isEditing
//        ? NfpPerformance.shared.editingPerformance.getIntegerNumberOfExercises() + 1
//        : SettingsManager.shared.getIntegerNumberOfExercises() + 1
        settings.getIntegerNumberOfExercises() + 1
   }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       1
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell
        cell.collectionView = collectionView
        cell.exercises = exercises[indexPath.row]
       
        return cell
    }
}
    

//MARK: -  UICollectionViewDelegate, UICollectionViewDataSource

extension NfpViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exercises[1].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.identifier)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.identifier, for: indexPath) as! ExerciseCollectionViewCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let visibleCell = collectionView.visibleCells.first else { return }
        guard  let indexPathForVisibleCell = collectionView.indexPath(for: visibleCell) else { return }
        
        if NfpPerformanceManager.shared.exercises[collectionView.tag].name != exercises[collectionView.tag][indexPathForVisibleCell.item].name {
            NfpPerformanceManager.shared.exercises[collectionView.tag] = exercises[collectionView.tag][indexPathForVisibleCell.item]
            guard let tableCell = tableView.cellForRow(at: IndexPath(row: 0, section: collectionView.tag)) as? ResultTableViewCell else { return }
            
            tableCell.updateResults()
        }
        
        tableView.visibleCells.forEach { cell in
            guard let totalScoreCell = cell as? TotalScoreTableViewCell else { return }
            totalScoreCell.configureCell()
        }
    }
}
//MARK: - CollectionFlowLayout

extension NfpViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let space = UIScreen.main.bounds.width / 8
        
        return UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        UIScreen.main.bounds.width / 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 4 * 3, height: UIScreen.main.bounds.height / 4)
    }
    
}

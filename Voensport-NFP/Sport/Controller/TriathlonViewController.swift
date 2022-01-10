//
//  TriathlonViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class TriathlonViewController: UIViewController {
    
    private var tableView: UITableView!
    var triathlonController: TriathlonController!
    var updateUIAfterEditingDelegate: UpdateUIAfterEditingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setupNavigationBar()
        triathlonController.updateTriathlonExercises()
        hideKeyboardWhenTappedOutside()
    }
    
    private func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SegmentedViewCell.self, forCellReuseIdentifier: SegmentedViewCell.identifier)
        tableView.register(SportExerciseCell.self, forCellReuseIdentifier: SportExerciseCell.identifier)
        tableView.register(TotalScoreSportCell.self, forCellReuseIdentifier: TotalScoreSportCell.identifier)
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
    }
    
    private func setupNavigationBar() {
        
        if triathlonController.isEditing {
            navigationController?.navigationBar.prefersLargeTitles = true
            title = triathlonController.editingResultDate
            
            let closeAction = UIAction { [ unowned self ] _ in
                self.dismiss(animated: true, completion: nil)
                updateUIAfterEditingDelegate?.updateUI(indexPath: triathlonController.editingResultIndex)
               
            }
            
            let closeButton = UIBarButtonItem(systemItem: .close, primaryAction: closeAction, menu: nil)
            navigationItem.rightBarButtonItem = closeButton
            
        } else {
            navigationItem.largeTitleDisplayMode = .never
            
            title = triathlonController.triathlonType == .summer
            ? "Летнее офицерское троеборье"
            : "Зимнее офицерское троеборье"
        }
    }
    
    private func updateAfterAgeSegmentSelected(_ selectedSegment: Int) {
        triathlonController.ageCategory = TriathlonAgeCategory.allCases[selectedSegment]
        triathlonController.updateTriathlonExercises()
        
        tableView.visibleCells.forEach { cell in
            if let cell = cell as? SportExerciseCell {
                cell.exercise = triathlonController.exercises[cell.tag]
                cell.configureCell()
            }
        }
        updateTotalScoreCell()
    }
    
    private func updateTotalScoreCell() {
        tableView.visibleCells.forEach { cell in
            guard let totalScoreCell = cell as? TotalScoreSportCell else { return }
            totalScoreCell.configureCell(sportController: triathlonController)
        }
    }
    
    private func saveSportResult() {
        let sportResult = triathlonController.generateSportResult()
        
        if triathlonController.isEditing {
            StorageManager.shared.editSportResult(with: triathlonController.editingResultIndex, and: sportResult)
            updateUIAfterEditingDelegate?.updateUI(indexPath: triathlonController.editingResultIndex)
            dismiss(animated: true)
        } else {
            var resultsController = StorageManager.shared.getResults()
            resultsController.sportResults.insert(sportResult, at: 0)
            StorageManager.shared.saveResults(results: resultsController)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension TriathlonViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 45
        case 4:
            return 140
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SegmentedViewCell.identifier, for: indexPath) as! SegmentedViewCell
            
            cell.callBack = { [unowned self] selectedSegment in
                self.updateAfterAgeSegmentSelected(selectedSegment)
            }
            
            cell.configure(triathlonController.ageCategory)
            cell.ageSegmented.isEnabled = !triathlonController.isEditing
            cell.selectionStyle = .none
            return cell
            
        case 1...3:
            let cell = tableView.dequeueReusableCell(withIdentifier: SportExerciseCell.identifier, for: indexPath) as! SportExerciseCell
            cell.exercise = triathlonController.exercises[indexPath.row - 1]
            cell.configureCell()
            cell.tag = indexPath.row - 1
            
            cell.callBackForUpdatingTotalScore = { [unowned self] in
                self.updateTotalScoreCell()
            }
            
            cell.selectionStyle = .none
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TotalScoreSportCell.identifier, for: indexPath) as! TotalScoreSportCell
            cell.configureCell(sportController: triathlonController)
            
            cell.saveButtonCallBack = { [unowned self] in
                self.saveSportResult()
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

//MARK: - Hide keyboard method

extension TriathlonViewController {
    
    func hideKeyboardWhenTappedOutside() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


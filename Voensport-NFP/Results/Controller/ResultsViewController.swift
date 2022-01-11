//
//  ResultsViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 22.12.2021.
//

import UIKit

final class ResultsViewController: UIViewController {
    var resultsController: ResultsController!
    private var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Результаты"
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        resultsController = StorageManager.shared.getResults()
        tableView.reloadData()
    }
    
    private func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0
        ? resultsController.nfpResults.count
        : resultsController.sportResults.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        resultsController.getTitleForHeaderInSection(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = indexPath.section == 0
        ? resultsController.nfpResults[indexPath.row].date
        : resultsController.sportResults[indexPath.row].date
        
        content.secondaryText = indexPath.section == 0
        ? "\(resultsController.nfpResults[indexPath.row].grade)"
        : "\(resultsController.sportResults[indexPath.row].sportType.rawValue)"
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            StorageManager.shared.deleteResult(with: indexPath)
            
            if indexPath.section == 0 {
                self.resultsController.nfpResults.remove(at: indexPath.row)
            } else {
                self.resultsController.sportResults.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if self.resultsController.shouldReloadData {
                tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailResultVC = DetailResultViewController()
        detailResultVC.editingResultIndexPath = indexPath
        
        if indexPath.section == 0 {
            let nfpResult = resultsController.nfpResults[indexPath.row]
            detailResultVC.nfpResult = nfpResult
            detailResultVC.numberOfSectionForLayout = nfpResult.nfpExercises.count
        } else {
            detailResultVC.sportResult = resultsController.sportResults[indexPath.row]
        }
        
        let navController = UINavigationController(rootViewController: detailResultVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
}



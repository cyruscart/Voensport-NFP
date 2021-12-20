//
//  SportViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class TriathlonTableViewController: UITableViewController {
    
//    var editingPerformanceResult: PerformanceResult!
//    var editingIndexPath: IndexPath!
//    var performanceDelegate: PerformanceResultTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        SportPerformanceManager.shared.ageCategory = .lessThirty
//
//        SportPerformanceManager.shared.isEditing
//        ? SportPerformanceManager.shared.exercises = editingPerformanceResult.sportExercises
//        : SportPerformanceManager.shared.updateTriathlonExercises()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "segmentCell", for: indexPath) as! SegmentTableViewCell
//            cell.segmentDelegate = self
//            if SportPerformanceManager.shared.isEditing { cell.configureForEditing(with: editingPerformanceResult)
//            }
//            return cell
//
//        case 1...3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "sportExerciseCell", for: indexPath) as! SportExerciseTableViewCell
//            cell.cellIndex = indexPath.row - 1
//            cell.configureCell()
//            return cell
//
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "totalScoreSportCell", for: indexPath) as! TotalScoreSportTableViewCell
//            cell.configureCell()
//            cell.scoreEditDelegate = self
//            cell.indexPath = editingIndexPath
//            return cell
//        }
    }
    
    
}

  

//
//  DetailSettingsViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class DetailSettingsViewController: UIViewController {
    
    var settings: Settings!
    var currentSetting: String!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
      
    }
    private func setTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.separatorStyle = .singleLine
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DetailSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.getNumberOfRowsForDetailSettings(currentSetting)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        switch currentSetting {
        case "sex":
            content.text = Sex.allCases[indexPath.row].rawValue
            cell.accessoryType = settings.sex == Sex.allCases[indexPath.row]
            ? .checkmark
            : .none
            
        case "maleAge":
            content.text = MaleAgeCategory.allCases[indexPath.row].rawValue
            cell.accessoryType = settings.maleAgeCategory == MaleAgeCategory.allCases[indexPath.row]
            ? .checkmark
            : .none
            
        case "femaleAge":
            content.text = FemaleAgeCategory.allCases[indexPath.row].rawValue
            cell.accessoryType =  settings.femaleAgeCategory == FemaleAgeCategory.allCases[indexPath.row]
            ? .checkmark
            : .none
            
        case "numberOfExercise":
            content.text = settings.getNumberOfExerciseList()[indexPath.row].rawValue
            cell.accessoryType =  settings.numberOfExercise == settings.getNumberOfExerciseList()[indexPath.row]
            ? .checkmark
            : .none
            
        default:
            content.text = Category.allCases[indexPath.row].rawValue
            cell.accessoryType = settings.category == Category.allCases[indexPath.row]
            ? .checkmark
            : .none
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settings.settingDidSelect(didSelectRowAt: indexPath, currentSetting: currentSetting)
        
        tableView.reloadData()
    }
    
}

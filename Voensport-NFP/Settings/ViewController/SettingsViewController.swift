//
//  SettingsViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    var settings: Settings!
    private var tableView: UITableView!
    private var selectedSetting = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        settings.setNumberOfExercise()
        tableView.reloadData()
        
    }
    
    private func setTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        settings.getNumberOfSectionForSettings()
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settings.getTitleForSectionForSettingsList(section: section)
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.numberOfSections == indexPath.section + 1
//        ? tableView.dequeueReusableCell(withIdentifier: "hapticCell", for: indexPath) as! HapticTableViewCell
//        : tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        
//        if let cell = cell as? HapticTableViewCell {
//            cell.settingLabel.text = "При выборе результата"
//        } else {
//            var content = cell.defaultContentConfiguration()
//            content.text = SettingsManager.shared.getTextForCell(section: indexPath.section)
//            cell.contentConfiguration = content
//        }
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         var content = cell.defaultContentConfiguration()
         cell.accessoryType = .disclosureIndicator
         content.text = settings.getTextForCell(section: indexPath.section)
         
         cell.contentConfiguration = content
         
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settings.settingGroupDidSelect(indexPath, &selectedSetting) {
            let detailSettingsVC = DetailSettingsViewController()
            navigationController?.pushViewController(detailSettingsVC, animated: true)
        }
    }
    
    // MARK: - Navigation
    
    
}

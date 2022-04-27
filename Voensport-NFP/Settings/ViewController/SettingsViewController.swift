//
//  SettingsViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    var settings: Settings
    
    private var tableView: UITableView!
    private var selectedSetting = ""
    
    private var storage = SettingsStorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        navigationItem.largeTitleDisplayMode = .never
        setTableView()
    }
    
    init(_ settings: Settings) {
        self.settings = settings
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settings.setNumberOfExercise()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        storage.save(settings)
    }
    
    private func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
    }
    
    @objc private func hapticSwitchDidChange(hapticSwitch: UISwitch) {
        settings.hapticOn = hapticSwitch.isOn
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
        let cell = tableView.numberOfSections == indexPath.section + 1
        ? tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
        : tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? SwitchTableViewCell {
            cell.selectionStyle = .none
            cell.switchStatement.isOn = settings.hapticOn
            cell.settingNameLabel.text = "При выборе рузультата"
            cell.switchStatement.addTarget(self, action: #selector(hapticSwitchDidChange), for: .valueChanged)
        } else {
            var content = cell.defaultContentConfiguration()
            cell.accessoryType = .disclosureIndicator
            content.text = settings.getTextForCell(section: indexPath.section)
            cell.contentConfiguration = content
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settings.settingGroupDidSelect(indexPath, &selectedSetting) {
            let detailSettingsVC = DetailSettingsViewController(settings)
            detailSettingsVC.currentSetting = selectedSetting
            navigationController?.pushViewController(detailSettingsVC, animated: true)
        }
    }
}

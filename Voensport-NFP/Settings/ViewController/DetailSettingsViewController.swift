//
//  DetailSettingsViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class DetailSettingsViewController: UIViewController {
    var settings: Settings
    var currentSetting = ""
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle()
        setTableView()
    }
    
    init(_ settings: Settings) {
        self.settings = settings
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PickerTableViewCell.self, forCellReuseIdentifier: PickerTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
    }
    
    private func setNavigationTitle() {
        navigationItem.largeTitleDisplayMode = .never
        
        switch currentSetting {
        case "sex":
            title = "Пол"
        case "maleAge":
            title = "Возрастная категория"
        case "femaleAge":
            title = "Возрастная категория"
        case "numberOfExercise":
            title = "Количество упражнений"
        case "tariff":
            title = "Тарифный разряд"
        default:
            title = "Категория"
            setInfoButton()
        }
    }
    
    private func setInfoButton() {
        let infoButton = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .plain,
            target: self,
            action: #selector(showInfo))
        
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc private func showInfo() {
        let descriptionVC = DescriptionViewController()
        descriptionVC.configure(with: Info.categoryInfo)
        present(descriptionVC, animated: true)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension DetailSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        currentSetting == "tariff" ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentSetting == "tariff" ? 1 : settings.getNumberOfRowsForDetailSettings(currentSetting)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if currentSetting == "tariff" {
            title = section == 0 ? "Тарифный разряд" : "Спортивный разряд"
        }
        return title
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
            
        case "tariff":
            let cell = tableView.dequeueReusableCell(withIdentifier: PickerTableViewCell.identifier, for: indexPath) as! PickerTableViewCell
            let picker = createPicker(textField: cell.pickerTextField)
            picker.tag = indexPath.section
            
            if indexPath.section == 0 {
                cell.pickerTextField.placeholder = "Выберите тарифный разряд"
                cell.pickerTextField.text = settings.tariff == 0
                ? ""
                : "\(settings.tariff) тарифный разряд"
            } else {
                cell.pickerTextField.placeholder = "Выберите спортивный разряд"
                cell.pickerTextField.text = settings.sportGrade == nil
                ? ""
                : settings.sportGrade?.rawValue
            }
            return cell
            
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

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension DetailSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 0
        ? Tariff.tariff.count
        : SportGrade.paidSportGrade.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 0
        ? "\(Tariff.tariffNumbers[row]) тарифный разряд"
        : SportGrade.paidSportGrade[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            guard let cell = tableView.visibleCells.first as? PickerTableViewCell else { return }
            let tariff = Tariff.tariffNumbers[row]
            cell.pickerTextField.text = "\(tariff) тарифный разряд"
            settings.tariff = tariff
        } else {
            guard let cell = tableView.visibleCells.last as? PickerTableViewCell else { return }
            let sportGrade = SportGrade.paidSportGrade[row]
            cell.pickerTextField.text = sportGrade.rawValue
            settings.sportGrade = sportGrade
        }
    }
    
    private func createPicker (textField: UITextField) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: nil, action: #selector(donePressed))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexButton ,doneButton], animated: false)
        textField.inputAccessoryView = toolBar
        textField.inputView = picker
        
        return picker
    }
    
    @objc private func donePressed() {
        tableView.visibleCells.forEach { cell in
            guard let tariffCell = cell as? PickerTableViewCell else { return }
            tariffCell.pickerTextField.resignFirstResponder()
            
            guard let gradeCell = cell as? PickerTableViewCell else { return }
            gradeCell.pickerTextField.resignFirstResponder()
        }
    }
    
}

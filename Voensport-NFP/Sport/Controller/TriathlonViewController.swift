//
//  TriathlonViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class TriathlonViewController: UIViewController {
    
    private var tableView: UITableView!
    var sportController: SportController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
        navigationItem.largeTitleDisplayMode = .never
        
        title = sportController.triathlonType == .summer
        ? "Летнее офицерское троеборье"
        : "Зимнее офицерское троеборье"
        
        sportController.loadExercises()
        sportController.updateTriathlonExercises()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
}

// MARK: - Table view data source

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
            
            //            if SportPerformanceManager.shared.isEditing { cell.configureForEditing(with: editingPerformanceResult)
            //            }
            cell.selectionStyle = .none
            cell.configure(sportController.ageCategory)
            cell.callBack = { selectedSegment in
                self.updateAfterAgeSegmentSelected(selectedSegment)
            }
            
            return cell
            
        case 1...3:
            print("case 1...3")
            let cell = tableView.dequeueReusableCell(withIdentifier: SportExerciseCell.identifier, for: indexPath) as! SportExerciseCell
            let picker = createPicker(textField: cell.resultTextField)
            picker.tag = indexPath.row - 1
            cell.tag = indexPath.row - 1
            cell.selectionStyle = .none
            cell.configureCell(sportController.exercises[indexPath.row - 1])
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TotalScoreSportCell.identifier, for: indexPath) as! TotalScoreSportCell
            cell.configureCell(sportController: sportController)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    private func updateAfterAgeSegmentSelected(_ selectedSegment: Int) {
        
        
        sportController.ageCategory = SportType.TriathlonAgeCategory.allCases[selectedSegment]
        sportController.updateTriathlonExercises()
        
        tableView.visibleCells.forEach { cell in
            cell.reloadInputViews()
        }

    }
    
  
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension TriathlonViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sportController.exercises[pickerView.tag].getScoreList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(sportController.exercises[pickerView.tag].getScoreList()[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let newResult = String(sportController.exercises[pickerView.tag].getScoreList()[pickerView.selectedRow(inComponent: 0)])
        sportController.exercises[pickerView.tag].result = newResult
        
        guard let newScore = sportController.exercises[pickerView.tag].score else { return }
        
        tableView.visibleCells.forEach { cell in
            
            if let exCell = cell as? SportExerciseCell {
                if exCell.tag == pickerView.tag {
                    exCell.resultTextField.text = newResult
                    exCell.scoreLabel.text = "Баллов: \(newScore)"
                }
            } else if let totalCell = cell as? TotalScoreSportCell {
                totalCell.configureCell(sportController: sportController)
        }
    }
    }
    
    private func createPicker (textField: UITextField) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexButton ,doneButton], animated: false)
        textField.inputAccessoryView = toolBar
        textField.inputView = picker
        
        return picker
    }
    
    @objc private func donePressed() {
        
        tableView.visibleCells.forEach { cell in
            guard let exerciseCell = cell as? SportExerciseCell else { return }
            exerciseCell.resultTextField.resignFirstResponder()
            
        }
    }
}

//
//  SportExerciseCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class SportExerciseCell: UITableViewCell  {
    static let identifier = "SportExerciseCell"
    
    var exercise: SportExercise!
    var callBackForUpdatingTotalScore: (() -> Void) = {}
    
    var exerciseNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    var resultTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Выберите результат"
        return tf
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        createPicker(textField: resultTextField)
        
        [exerciseNameLabel, scoreLabel, resultTextField].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            exerciseNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            exerciseNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            resultTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 ),
            resultTextField.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 10),
            
            scoreLabel.leadingAnchor.constraint(equalTo: resultTextField.trailingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            scoreLabel.centerYAnchor.constraint(equalTo: resultTextField.centerYAnchor)
        ])
    }
    
    func configureCell() {
        createPicker(textField: resultTextField)
     
        exerciseNameLabel.text = exercise.name
        resultTextField.text = String(exercise.result)
        
        scoreLabel.text = exercise.score == 0
        ? ""
        : String(exercise.score)
    }
    
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension SportExerciseCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        exercise.getScoreList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(exercise.getScoreList()[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let newResult = String(exercise.getScoreList()[pickerView.selectedRow(inComponent: 0)])
        exercise.result = newResult
        
        let newScore = exercise.score
        
        resultTextField.text = newResult
        scoreLabel.text = "Баллов: \(newScore)"
        
        callBackForUpdatingTotalScore()
    }
    
    
    private func createPicker (textField: UITextField) {
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
    }
    
    @objc private func donePressed() {
        resultTextField.resignFirstResponder()
    }
    
}

//
//  SportExerciseCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

final class SportExerciseCell: UITableViewCell  {
    static let identifier = "SportExerciseCell"
    
    var exercise: TriathlonExercise!
    var callBackForUpdatingTotalScore: (() -> Void) = {}
    var exerciseNameLabel = UILabel()
    var scoreLabel = UILabel()
    private var picker = UIPickerView()
    
    let resultTextField: UITextField = {
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
        picker = createPicker(textField: resultTextField)
        let resultIndex = exercise.getIndexForEditingResult()
        
        exercise.result == ""
        ? picker.selectRow(exercise.getScoreList().count / 2, inComponent: 0, animated: false)
        : picker.selectRow(resultIndex, inComponent: 0, animated: false)
        
        exerciseNameLabel.text = exercise.name
        resultTextField.text = String(exercise.result)
        scoreLabel.text = exercise.score == 0 ? "" : "Баллов: \(exercise.score)"
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
    
    private func createPicker (textField: UITextField) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let upImage = UIImage(systemName: "chevron.up")
        let scrollUpButton = UIBarButtonItem(image: upImage, style: .plain, target: nil, action: #selector(scrollUp))
        
        let downImage = UIImage(systemName: "chevron.down")
        let scrollDownButton = UIBarButtonItem(image: downImage, style: .plain, target: nil, action: #selector(scrollDown))
            
        let clearButton = UIBarButtonItem(title: "Очистить", style: .done, target: nil, action: #selector(clearPressed))
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: nil, action: #selector(donePressed))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([scrollUpButton, scrollDownButton, flexButton , clearButton, doneButton], animated: false)
        textField.inputAccessoryView = toolBar
        textField.inputView = picker
        
        return picker
    }
    
    @objc private func donePressed() {
        resultTextField.resignFirstResponder()
    }
    
    @objc private func scrollUp() {
        picker.selectRow(0, inComponent: 0, animated: true)
    }
    
    @objc private func scrollDown() {
        picker.selectRow(exercise.getScoreList().count - 1, inComponent: 0, animated: true)
    }
    
    @objc private func clearPressed() {
        exercise.result = ""
        resultTextField.text = ""
        scoreLabel.text = "Баллов: \(exercise.score)"
        callBackForUpdatingTotalScore()
    }
}

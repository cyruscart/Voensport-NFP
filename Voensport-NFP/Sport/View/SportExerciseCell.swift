//
//  SportExerciseCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class SportExerciseCell: UITableViewCell  {
    static let identifier = "SportExerciseCell"
    
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
    
    func configureCell(_ exercise: SportExercise) {
        
        exerciseNameLabel.text = exercise.name
        
        if let score = exercise.score {
            scoreLabel.text = String(score)
        }
    }
    
    private func configureCellForEditing() {
        
        //        resultTextField.text = SportPerformanceManager.shared.exercises[cellIndex].result
        //        scoreLabel.text = "Баллов: \(String(SportPerformanceManager.shared.exercises[cellIndex].score ?? 0))"
        //
        //        let resultIndex = SportPerformanceManager.shared.exercises[cellIndex].getIndexForEditingResult()
        //
        //        SportPerformanceManager.shared.exercises[cellIndex].result == ""
        //        ? resultPicker.selectRow(SportPerformanceManager.shared.exercises[cellIndex].getScoreList().count / 2, inComponent: 0, animated: false)
        //        : resultPicker.selectRow(resultIndex, inComponent: 0, animated: false)
        //    }
        
        
    }
}

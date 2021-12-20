//
//  SportExerciseCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class SportExerciseCell: UITableViewCell  {
    static let identifier = "SportExerciseCell"
    
    private var exerciseNameLabel = UILabel()
    private var scoreLabel = UILabel()
    private var resultTextField =  UITextField()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell() {
        //        if SportPerformanceManager.shared.isEditing {
        //            configureCellForEditing()
        //        } else {
        //        resultTextField.text = ""
        //        scoreLabel.text = "Баллов:"
        //        resultPicker.selectRow(SportPerformanceManager.shared.exercises[cellIndex].getScoreList().count / 2, inComponent: 0, animated: false)
        //    }
        //        exerciseNameLabel.text = SportPerformanceManager.shared.exercises[cellIndex].name
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

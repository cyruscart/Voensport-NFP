//
//  TotalScoreSportCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 21.12.2021.
//

import UIKit

class TotalScoreSportCell: UITableViewCell  {
    static let identifier = "TotalScoreSportCell"
    
    private var totalScoreLabel = UILabel()
    private var gradeLabel = UILabel()
    
    private var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 17/255,
                                         green: 60/255,
                                         blue: 252/255,
                                         alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        
        [totalScoreLabel, gradeLabel, saveButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            totalScoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            totalScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            gradeLabel.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 10),
            gradeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureCell(sportController: SportController) {
        totalScoreLabel.text = "Баллов: \(sportController.totalScore)"
        gradeLabel.text = sportController.calculateTriathlonGrade()
    }
    
    private func configureCellForEditing() {
        
    }
}

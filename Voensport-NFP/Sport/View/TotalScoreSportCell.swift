//
//  TotalScoreSportCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 21.12.2021.
//

import UIKit

final class TotalScoreSportCell: UITableViewCell  {
    static let identifier = "TotalScoreSportCell"
    
    private let totalScoreLabel = UILabel()
    private let gradeLabel = UILabel()
    
    private let saveButton: UIButton = {
        let button = UIButton.createSaveButton()
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var saveButtonCallBack: (() -> Void) = {}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        setSubviews(on: contentView, totalScoreLabel, gradeLabel, saveButton)
        
        NSLayoutConstraint.activate([
            totalScoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            totalScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            gradeLabel.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 10),
            gradeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
    
    func configureCell(sportController: TriathlonController) {
        totalScoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        gradeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        totalScoreLabel.text = "Сумма баллов: \(sportController.totalScore)"
        gradeLabel.text = sportController.calculateTriathlonGrade()
        
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.isHidden = !sportController.shouldShowTotalScore()
        totalScoreLabel.isHidden = !sportController.shouldShowTotalScore()
    }
    
    @objc private func saveButtonPressed() {
        if saveButton.title(for: .normal) == "Сохранить" {
            saveButton.pulsate()
            saveButton.setTitle("Сохранено", for: .normal)
            saveButtonCallBack()
        }
    }
}

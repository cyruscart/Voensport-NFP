//
//  TotalScoreCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 09.12.2021.
//

import UIKit

class TotalScoreCell: UICollectionViewCell {
    
    static let identifier = "TotalScoreCell"
    
    private var totalScoreLabel = UILabel()
    private var gradeLabel = UILabel()
    private var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        
        
        [totalScoreLabel, gradeLabel,saveButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        let inset = CGFloat(20)
        
        NSLayoutConstraint.activate([
            totalScoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            totalScoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            totalScoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            
            gradeLabel.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 10),
            gradeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            gradeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            
            saveButton.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            saveButton.widthAnchor.constraint(equalToConstant: 50)
            
            
            
        ])
    }
    
     func configureCell(with nfpPerformance: NfpPerformance) {
         totalScoreLabel.text = "Количество баллов - \(nfpPerformance.totalScore)"
         gradeLabel.text = nfpPerformance.getTextForGradeLabel()
         
    }
}

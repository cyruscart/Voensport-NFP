//
//  TotalScoreCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 09.12.2021.
//

import UIKit

class TotalScoreCell: UICollectionViewCell {
    static let identifier = "TotalScoreCell"
    
    private var totalScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private var gradeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        backgroundColor = .lightGray
        contentView.alpha = 0.5
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
        let width = UIScreen.main.bounds.width - inset * 2
        let height = CGFloat(40)
        
        NSLayoutConstraint.activate([
            totalScoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            totalScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            totalScoreLabel.widthAnchor.constraint(equalToConstant: width),
        
            gradeLabel.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 10),
            gradeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            gradeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            
            saveButton.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
     func configureCell(with nfpPerformance: NfpController) {
         totalScoreLabel.text = "Количество баллов - \(nfpPerformance.totalScore)"
         gradeLabel.text = nfpPerformance.getTextForGradeLabel()
         
    }
}

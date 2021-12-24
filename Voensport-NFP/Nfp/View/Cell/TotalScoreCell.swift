//
//  TotalScoreCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 09.12.2021.
//

import UIKit

class TotalScoreCell: UICollectionViewCell {
    static let identifier = "TotalScoreCell"
    
    var saveButtonCallBack: (() -> Void) = {}
    
    private var totalScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    
    private var markLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private var gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        return label
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 17/255,
                                         green: 60/255,
                                         blue: 252/255,
                                         alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var moneyButton: UIButton = {
        let button = UIButton()
        button.setTitle("\u{20BD}", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 17/255,
                                         green: 60/255,
                                         blue: 252/255,
                                         alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupConstraints()
        
        backgroundColor = .systemBackground
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = 15
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [totalScoreLabel, gradeLabel, markLabel, saveButton, moneyButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        let inset = CGFloat(20)
        let width = UIScreen.main.bounds.width - inset * 2
        
        
        NSLayoutConstraint.activate([
            totalScoreLabel.topAnchor.constraint(equalTo: markLabel.topAnchor),
            totalScoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            gradeLabel.bottomAnchor.constraint(equalTo: markLabel.bottomAnchor),
            gradeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            markLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            markLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset * 3),
            
            
            
            saveButton.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: moneyButton.trailingAnchor, constant: inset / 2),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            moneyButton.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 20),
            moneyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            moneyButton.widthAnchor.constraint(equalToConstant: width / 5 - inset / 2),
            moneyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureCell(with nfpController: NfpController) {
        totalScoreLabel.text = "Баллов: \(nfpController.totalScore)"
        markLabel.text = nfpController.getMarkForTotalScoreLabel()
        gradeLabel.text = nfpController.getGradeForTotalScoreLabel()
        saveButton.setTitle("Сохранить", for: .normal)
    }
    
    @objc private func saveButtonPressed() {
        if saveButton.title(for: .normal) == "Сохранить" {
            saveButton.setTitle("Сохранено", for: .normal)
            saveButtonCallBack()
        }
    }
    
}

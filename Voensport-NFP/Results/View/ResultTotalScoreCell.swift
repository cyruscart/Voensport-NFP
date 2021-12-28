//
//  ResultTotalScoreCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 23.12.2021.
//

import UIKit

class ResultTotalScoreCell: UICollectionViewCell {
    static let identifier = "ResultTotalScoreCell"
    
    var saveButtonCallBack: (() -> Void) = {}
    var editButtonCallBack: (() -> Void) = {}
    
    private var totalScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private var gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .center
        return label
    }()
    
    var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 29/255,
                                         green: 201/255,
                                         blue: 58/255,
                                         alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("Изменить", for: .normal)
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 17/255,
                                         green: 60/255,
                                         blue: 252/255,
                                         alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("Закрыть", for: .normal)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
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
        [totalScoreLabel, gradeLabel, saveButton, editButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        let inset = CGFloat(20)
        
        NSLayoutConstraint.activate([
            totalScoreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            totalScoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            totalScoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            gradeLabel.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 10),
            gradeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            gradeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            editButton.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 15),
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            editButton.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 15),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            
            
        ])
    }
    
    func configureCell(sportResult: SportResult) {
        totalScoreLabel.text = "Сумма баллов: \(sportResult.totalScore)"
        gradeLabel.text = sportResult.grade
    }
    
    func configureCell(nfpResult: NfpResult) {
        totalScoreLabel.text = "Сумма баллов: \(nfpResult.totalScore)"
        gradeLabel.text = nfpResult.grade
    }
    
    @objc private func saveButtonPressed() {
            saveButtonCallBack()
    }
    
    @objc private func editButtonPressed() {
            editButtonCallBack()
        }
    
}

//
//  ResultTotalScoreCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 23.12.2021.
//

import UIKit

final class ResultTotalScoreCell: UICollectionViewCell {
    static let identifier = "ResultTotalScoreCell"
    
    let editButton: UIButton = {
        let button = UIButton.createSaveButton()
        button.backgroundColor = UIColor.AppColor.green
        button.setTitle("Изменить", for: .normal)
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton.createSaveButton()
        button.setTitle("Закрыть", for: .normal)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let totalScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    var saveButtonCallBack: (() -> Void) = {}
    var editButtonCallBack: (() -> Void) = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupConstraints()
        setViewShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        setSubviews(on: contentView, totalScoreLabel, gradeLabel, saveButton, editButton)
        
        backgroundColor = .AppColor.white
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 15
        layer.masksToBounds = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            totalScoreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            totalScoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            totalScoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            gradeLabel.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 10),
            gradeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gradeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            editButton.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 15),
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            saveButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 15),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
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

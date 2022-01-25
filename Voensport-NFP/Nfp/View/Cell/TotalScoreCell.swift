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
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    private let totalScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let markLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton.createSaveButton()
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let moneyButton: UIButton = {
        let button = UIButton.createSaveButton()
        button.setTitle("\u{20BD}", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupConstraints()
        
        backgroundColor = .AppColor.white
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 15
        layer.masksToBounds = false
        
        setViewShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        setSubviews(on: contentView, mainStackView, saveButton, moneyButton)
        configureStackView()
    }
    
    private func setupConstraints() {
        let inset = CGFloat(20)
        let width = UIScreen.main.bounds.width - inset * 2
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            mainStackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: 0),
            
            saveButton.leadingAnchor.constraint(equalTo: moneyButton.trailingAnchor, constant: inset / 2),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            
            moneyButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            moneyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            moneyButton.widthAnchor.constraint(equalToConstant: width / 5 - inset / 2),
        ])
    }
    
    private func configureStackView() {
        [totalScoreLabel, gradeLabel].forEach { subview in
            labelStackView.addArrangedSubview(subview)
        }
        
        [labelStackView, markLabel].forEach { subview in
            mainStackView.addArrangedSubview(subview)
        }
    }
    
    func configureCell(with nfpController: NfpController) {
        totalScoreLabel.text = "Баллов: \(nfpController.totalScore)"
        markLabel.text = nfpController.getMarkForTotalScoreLabel()
        gradeLabel.text = nfpController.getGradeForTotalScoreLabel()
        saveButton.setTitle("Сохранить", for: .normal)
    }
    
    @objc private func saveButtonPressed() {
        if saveButton.title(for: .normal) == "Сохранить" {
            saveButton.pulsate()
            saveButton.setTitle("Сохранено", for: .normal)
            saveButtonCallBack()
        }
    }
    
}

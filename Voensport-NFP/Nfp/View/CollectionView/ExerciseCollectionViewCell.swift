//
//  ExerciseCollectionViewCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExerciseCollectionViewCell"
    
    private var backGroundImageView = UIImageView()
    private var descriptionButton = UIButton(type: .infoDark)
    private var exerciseTypeLabel = UILabel()
    private var exerciseNumberLabel = UILabel()
    private var exerciseNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backGroundImageView)
        
        [descriptionButton, exerciseTypeLabel,exerciseNumberLabel, exerciseNameLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            backGroundImageView.addSubview(view)
        }
    }
    
    private func setupConstraints() {
        backGroundImageView.frame = contentView.bounds
        NSLayoutConstraint.activate([
            //            backGroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //            backGroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            //            backGroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            //            backGroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            exerciseTypeLabel.topAnchor.constraint(equalTo: backGroundImageView.topAnchor, constant: 10),
            exerciseTypeLabel.trailingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor, constant: -10),
            exerciseTypeLabel.leadingAnchor.constraint(equalTo: descriptionButton.trailingAnchor),
            
            descriptionButton.topAnchor.constraint(equalTo: backGroundImageView.topAnchor, constant: 3),
            descriptionButton.widthAnchor.constraint(equalToConstant: 45),
            descriptionButton.trailingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor),
            
            exerciseNumberLabel.leadingAnchor.constraint(equalTo: backGroundImageView.leadingAnchor, constant: 30),
            exerciseNumberLabel.trailingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor, constant: -30),
            exerciseNumberLabel.bottomAnchor.constraint(equalTo: backGroundImageView.topAnchor, constant: 85),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: exerciseNumberLabel.topAnchor),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: backGroundImageView.leadingAnchor, constant: 10),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor, constant: -10),
            exerciseNameLabel.bottomAnchor.constraint(equalTo: backGroundImageView.bottomAnchor, constant: 15)
        ])
    }
    
     func configureCell(with exercise: NfpExercise) {
        exerciseTypeLabel.text = exercise.type.rawValue
        exerciseNameLabel.text = exercise.name
        exerciseNumberLabel.text = exercise.number
        
        switch exercise.type {
            case .power:
                backGroundImageView.image = UIImage(named: "power")
            case .agility:
                backGroundImageView.image = UIImage(named: "agility")
            case .speed:
                backGroundImageView.image = UIImage(named: "speed")
            case .endurance:
                backGroundImageView.image = UIImage(named: "endurance")
            case .militarySkill:
                backGroundImageView.image = UIImage(named: "militarySkill")
            }
            
        }
    }

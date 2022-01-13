//
//  ExerciseCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import UIKit

class ExerciseCell: UICollectionViewCell {
    static let identifier = "ExerciseCell"
    
    var callback: ((_ exercise: NfpExercise) -> Void)!
    var exercise: NfpExercise!
    private var backGroundImageView = UIImageView()
    
    var descriptionButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.tintColor = .black
        button.addTarget(self, action: #selector(descriptionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var exerciseNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backGroundImageView)
        
        [descriptionButton,exerciseNumberLabel, exerciseNameLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            backGroundImageView.addSubview(view)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backGroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backGroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backGroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backGroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            descriptionButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            descriptionButton.widthAnchor.constraint(equalToConstant: 45),
            descriptionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            exerciseNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            exerciseNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            exerciseNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            exerciseNumberLabel.heightAnchor.constraint(equalToConstant: layer.bounds.height / 4.5),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: exerciseNumberLabel.bottomAnchor),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            exerciseNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell() {
        exerciseNameLabel.text = exercise.name
        exerciseNumberLabel.text = exercise.number
        descriptionButton.isHidden = exercise.exerciseDescription == nil
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 15
        layer.masksToBounds = false
        
        setViewShadows()
        layer.shadowRadius = 10
        
        setImages()
    }
    
    private func setImages() {
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
    
    @objc private func descriptionButtonTapped() {
        callback(exercise)
    }
    
}

// MARK: - Fixed a bug where the description button did not recognize the touch

extension ExerciseCell {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if descriptionButton.point(inside: convert(point, to: descriptionButton), with: event) {
            return descriptionButton
        }
        return super.hitTest(point, with: event)
    }
}

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
    
    private var exerciseTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var exerciseNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        
        [descriptionButton, exerciseTypeLabel,exerciseNumberLabel, exerciseNameLabel].forEach { view in
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
            
            exerciseTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            exerciseTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            exerciseTypeLabel.trailingAnchor.constraint(equalTo: descriptionButton.leadingAnchor, constant: -10),
            
            descriptionButton.topAnchor.constraint(equalTo: backGroundImageView.topAnchor, constant: 10),
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
    
    func configureCell() {
        exerciseTypeLabel.text = exercise.type.rawValue
        exerciseNameLabel.text = exercise.name
        exerciseNumberLabel.text = exercise.number
        descriptionButton.isHidden = exercise.exerciseDescription == nil
        
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
        
//        guard isUserInteractionEnabled else { return nil }
//        guard !isHidden else { return nil }
//        guard alpha >= 0.01 else { return nil }
//        guard self.point(inside: point, with: event) else { return nil }
        
        if descriptionButton.point(inside: convert(point, to: descriptionButton), with: event) {
            return descriptionButton
        }
        return super.hitTest(point, with: event)
    }
}

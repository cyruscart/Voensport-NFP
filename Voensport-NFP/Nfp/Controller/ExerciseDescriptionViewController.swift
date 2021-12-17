//
//  ExerciseDescriptionViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 15.12.2021.
//

import UIKit

class ExerciseDescriptionViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let exerciseImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Понятно", for: .normal)
        button.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        
        button.backgroundColor = UIColor(displayP3Red: 17/255,
                                         green: 60/255,
                                         blue: 252/255,
                                         alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupScrollView()
        setupViews()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupViews() {
        [exerciseImage, descriptionLabel, okButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        
        let inset = CGFloat(20)
        
        NSLayoutConstraint.activate([
            exerciseImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            exerciseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            exerciseImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            descriptionLabel.topAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            descriptionLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -30),
            
            
            okButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            okButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            okButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            okButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with exercise: NfpExercise) {
        
            
            if let descriptionText = exercise.exerciseDescription {
                descriptionLabel.text = descriptionText
            }
            
            exerciseImage.image = UIImage(named: "\(exercise.number)")
//        } else {
//            descriptionLabel.text = DataManager.shared.gradeRules
//        }
    }
    
    @objc private func okButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
   
}

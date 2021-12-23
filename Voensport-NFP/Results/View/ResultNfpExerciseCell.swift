//
//  ResultNfpExerciseCell..swift
//  Voensport-NFP
//
//  Created by Кирилл on 23.12.2021.
//

import UIKit

class ResultNfpExerciseCell: UICollectionViewCell {
    static let identifier = "ResultNfpExerciseCell"
    
    var saveButtonCallBack: (() -> Void) = {}
    var editButtonCallBack: (() -> Void) = {}
    
    private var exerciseNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private var exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.numberOfLines
        
        return label
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        return label
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
        [exerciseNameLabel, exerciseNumberLabel, resultLabel, scoreLabel].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            exerciseNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            exerciseNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            exerciseNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: exerciseNumberLabel.bottomAnchor, constant: 10),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 10),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configureCell(nfpExercise: NfpExercise) {
        exerciseNameLabel.text = nfpExercise.name
        exerciseNumberLabel.text = nfpExercise.number
        scoreLabel.text = "Баллов: \(nfpExercise.score)"
        resultLabel.text = "Результат: \(nfpExercise.result ?? "")"
       
    }
    
    func configureCell(sportResult: SportResult, index: Int) {
       
        if index == 0 {
            exerciseNumberLabel.text = sportResult.sportType.rawValue
        } else {
            exerciseNumberLabel.isHidden = true
        }
        
        exerciseNameLabel.text = sportResult.sportExercises[index].name
        scoreLabel.text = "Баллов: \(sportResult.sportExercises[index].score)"
        resultLabel.text = "Результат: \(sportResult.sportExercises[index].result)"
    }
    
}


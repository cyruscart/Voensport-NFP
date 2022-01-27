//
//  ResultExerciseCell..swift
//  Voensport-NFP
//
//  Created by Кирилл on 23.12.2021.
//

import UIKit

final class ResultExerciseCell: UICollectionViewCell {
    static let identifier = "ResultNfpExerciseCell"
    
    private let exerciseNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        
        label.textAlignment = .left
        return label
    }()
    
    var saveButtonCallBack: (() -> Void) = {}
    var editButtonCallBack: (() -> Void) = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        backgroundColor = .systemBackground
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
        setSubviews(on: contentView, exerciseNameLabel, exerciseNumberLabel, resultLabel, scoreLabel)
    
        NSLayoutConstraint.activate([
            exerciseNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            exerciseNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            exerciseNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: exerciseNumberLabel.bottomAnchor, constant: 10),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            resultLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 15),
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            scoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell(nfpExercise: NfpExercise) {
        exerciseNameLabel.text = nfpExercise.name
        exerciseNumberLabel.text = nfpExercise.number
        scoreLabel.text = "Баллов: \(nfpExercise.score)"
        resultLabel.text = "Результат: \(nfpExercise.result ?? "")"
    }
    
    func configureCell(sportResult: SportResult, index: Int) {
        exerciseNumberLabel.isHidden = true
        exerciseNameLabel.text = sportResult.sportExercises[index].name
        scoreLabel.text = "Баллов: \(sportResult.sportExercises[index].score)"
        
        resultLabel.text = sportResult.sportExercises[index].result == ""
        ? "Результат не сохранен"
        : "Результат: \(sportResult.sportExercises[index].result)"
    }
    
}

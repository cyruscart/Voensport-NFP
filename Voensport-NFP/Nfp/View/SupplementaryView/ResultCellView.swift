//
//  ResultCellView.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import UIKit

class ResultCellView: UICollectionReusableView {
    static let identifier = "ResultCellView"
    
    var exercise: NfpExercise!
    var minimumScore = 0
    var callback: (() -> Void) = {}
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let resultSlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(resultSliderMoved), for: .valueChanged)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        setSubviews(on: self, resultLabel, resultSlider, scoreLabel)
        
        let width = UIScreen.main.bounds.width - 30
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            resultLabel.widthAnchor.constraint(equalToConstant: width / 3 * 2),
            
            scoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            scoreLabel.widthAnchor.constraint(equalToConstant: width / 3),
            
            resultSlider.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            resultSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            resultSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func configureCell() {
        resultSlider.minimumValue = Float(exercise.getScoreList().first ?? 0)
        resultSlider.maximumValue = Float(exercise.getScoreList().last ?? 100)
        resultSlider.setValue(Float(exercise.score), animated: false)
        setSliderTrackColor()
        setResults()
    }
    
    private func setSliderTrackColor() {
        resultSlider.minimumTrackTintColor = lrintf(resultSlider.value) < minimumScore ?
        UIColor.systemRed :
        UIColor.systemBlue
    }
    
    private func setResults() {
        scoreLabel.text = "Баллов: \(exercise.score)"
        resultLabel.text = "Результат: \(exercise.result ?? "0")"
    }
    
    @objc func resultSliderMoved() {
        setSliderTrackColor()
        
        if exercise.getScoreList().contains(lrintf(resultSlider.value)) && lrintf(resultSlider.value) != exercise.score  {
            exercise.score = lrintf(resultSlider.value)
            callback()
        }
        
        setResults()
    }
    
}

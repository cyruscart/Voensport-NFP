//
//  ResultCellView.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import UIKit

class ResultCellView: UICollectionReusableView {
    
    static let identifier = "ResultCellView"
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Результат: 100"
        label.textAlignment = .center
        return label
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Баллов: 100"
        label.textAlignment = .center
        return label
    }()
    
    private var resultSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.value = 50
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {

        [ resultLabel, resultSlider, scoreLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
    
            resultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            scoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            scoreLabel.widthAnchor.constraint(equalToConstant: 120),
            
            resultSlider.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            resultSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            resultSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func configureCell(_ collectionView: UICollectionView, _ exercise: NfpExercise) {
        resultSlider.minimumValue = Float(exercise.getScoreList().first ?? 0)
        resultSlider.maximumValue = Float(exercise.getScoreList().last ?? 100)
        
        
    }
    
}

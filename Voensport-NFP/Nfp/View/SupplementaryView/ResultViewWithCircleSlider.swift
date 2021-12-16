
//
//  ResultCellView.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import UIKit

class ResultView: UICollectionReusableView {
    
    static let identifier = "ResultView"
    
    var exercise: NfpExercise!
    var minimumScore = 0
    var completion: (() -> Void) = {}
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var resultSlider: CircleSlider = {
        let slider = CircleSlider(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        slider.backgroundColor = .green
        slider.addTarget(self, action: #selector(resultSliderMoved), for: .valueChanged)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {

        [ resultLabel, resultSlider, scoreLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subView)
        }
        
        let width = (UIScreen.main.bounds.width - 20) / 2
        
        NSLayoutConstraint.activate([
    
            resultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            resultLabel.widthAnchor.constraint(equalToConstant: width),
            
            scoreLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            scoreLabel.widthAnchor.constraint(equalToConstant: width),
            
            resultSlider.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            resultSlider.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 20),
            resultSlider.widthAnchor.constraint(equalToConstant: 100),
            resultSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func configureCell() {
        resultSlider.minimumValue = Float(exercise.getScoreList().first ?? 0)
        resultSlider.maximumValue = Float(exercise.getScoreList().last ?? 100)
        
        resultSlider.setValue(Float(exercise.score), animated: true)
        
//        setSliderTrackColor()
        setResults()
        
    }
    
//     private func setSliderTrackColor() {
//
//        resultSlider.minimumTrackTintColor = lrintf(resultSlider.value) < minimumScore ?
//         UIColor.systemRed :
//         UIColor.systemBlue
//    }
    
    private func setResults() {
        scoreLabel.text = "Баллов: \(exercise.score)"
        resultLabel.text = "Результат: \(exercise.result ?? "0")"
    }
    
     @objc func resultSliderMoved() {
//        setSliderTrackColor()
        
         
        if exercise.getScoreList().contains(lrintf(resultSlider.value)) && lrintf(resultSlider.value) != exercise.score  {
            exercise.score = lrintf(resultSlider.value)
            
        }
         setResults()
        
         completion()

    }
    
}

extension ResultView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
//        guard isUserInteractionEnabled else { return nil }
//        guard !isHidden else { return nil }
//        guard alpha >= 0.01 else { return nil }
//        guard self.point(inside: point, with: event) else { return nil }
        
        if resultSlider.point(inside: convert(point, to: resultSlider), with: event) {
            return resultSlider
        }
        return super.hitTest(point, with: event)
    }
}

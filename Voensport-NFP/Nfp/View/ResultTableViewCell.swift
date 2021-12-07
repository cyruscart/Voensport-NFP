//
//  ResultTableViewCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    static let identifier = "ResultTableViewCell"
    
    var collectionView: UICollectionView!
    var exercises: [NfpExercise]!
    
    private var scoreLabel = UILabel()
    private var resultLabel =  UILabel()
    
    private var resultSlider: UISlider = {
        let slider = UISlider()
        
        return slider
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        guard let collectionView = collectionView else { return }
        
        [collectionView, resultLabel, resultSlider, scoreLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            resultLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 5),
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            scoreLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 5),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            scoreLabel.widthAnchor.constraint(equalToConstant: 120),
            
            resultSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            resultSlider.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
        ])
    }
    
    func configureCell(_ collectionView: UICollectionView, _ exercises: [NfpExercise]) {
//        resultSlider.minimumValue = Float(exercises.getScoreList().first ?? 0)
//        resultSlider.maximumValue = Float(exercises.getScoreList().last ?? 100)
    }
    
}

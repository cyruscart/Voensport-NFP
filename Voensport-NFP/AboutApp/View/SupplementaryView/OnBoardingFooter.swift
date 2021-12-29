//
//  OnBoardingFooter.swift
//  Voensport-NFP
//
//  Created by Кирилл on 29.12.2021.
//

import UIKit

class OnBoardingFooter: UICollectionReusableView {
    static let identifier = "OnBoardingFooter"
   
    var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 17/255,
                                         green: 60/255,
                                         blue: 252/255,
                                         alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("Далее", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        print("suool")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            addSubview(nextButton)
       
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: topAnchor),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func configure() {
}
}



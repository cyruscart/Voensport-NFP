//
//  Extension+UIButton.swift
//  Voensport-NFP
//
//  Created by Кирилл on 29.12.2021.
//

import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        pulse.duration = 0.2
        pulse.fromValue = 1
        pulse.toValue = 1.15
        pulse.autoreverses = true
        pulse.initialVelocity = 0.7
        
        layer.add(pulse, forKey: nil)
    }
    
    static func createSaveButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 17/255,
                                         green: 60/255,
                                         blue: 252/255,
                                         alpha: 1)
        button.layer.cornerRadius = 15
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }
}
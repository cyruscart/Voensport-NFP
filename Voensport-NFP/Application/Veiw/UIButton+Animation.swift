//
//  UIButton+Animation.swift
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
        button.backgroundColor = AppColor.blue
        button.layer.cornerRadius = 13
        let height = UIScreen.main.bounds.width / 10
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        return button
    }
    
}

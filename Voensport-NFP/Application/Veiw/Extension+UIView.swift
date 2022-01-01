//
//  Extension+UIView.swift
//  Voensport-NFP
//
//  Created by Кирилл on 30.12.2021.
//

import UIKit

extension UIView {
    
    func setViewShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
    }
    
    enum AppColor {
        static let blue = UIColor(displayP3Red: 17/255,
                            green: 60/255,
                            blue: 252/255,
                            alpha: 1)
        
        static let green = UIColor(displayP3Red: 29/255,
                             green: 201/255,
                             blue: 58/255,
                             alpha: 1)
    }
    
}

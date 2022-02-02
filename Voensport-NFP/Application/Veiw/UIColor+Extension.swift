//
//  UIColor+Extension.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import UIKit

extension UIColor {
    
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
    
    static func cellColor(style: UIUserInterfaceStyle) -> UIColor {
        style == .dark ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.171124793) : .white
    }
    
}

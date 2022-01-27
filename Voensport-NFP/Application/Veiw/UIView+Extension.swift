//
//  UIView+Extension.swift
//  Voensport-NFP
//
//  Created by Кирилл on 30.12.2021.
//

import UIKit

extension UIView {
    
    func setSubviews(on superView: UIView, _ subviews: UIView...) {
        subviews.forEach { subview in
            superView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setViewShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
    }
    
    
    
}

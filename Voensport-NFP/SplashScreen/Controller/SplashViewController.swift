//
//  SplashViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 04.12.2021.
//

import UIKit

class SplashViewController: UIViewController {

    private var logoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoImageView)
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showLogo(images: 27)
    }
}

// MARK: - Show logo method

extension SplashViewController {
    
    private func showLogo(images count: Int) {
        var logoImages: [UIImage] = []

        for image in 0...count {
            logoImages.append(UIImage(named: "\(image)")!)
        }
        
        logoImageView.animationImages = logoImages
        logoImageView.animationDuration = 2
        logoImageView.animationRepeatCount = 1
        logoImageView.startAnimating()
    }
    
}

// MARK: - Layout
extension SplashViewController {
    
    private func setConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1)
        ])
    }
}

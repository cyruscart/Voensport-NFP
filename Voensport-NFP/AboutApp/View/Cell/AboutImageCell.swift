//
//  AboutImageCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 28.12.2021.
//

import UIKit

final class AboutImageCell: UICollectionViewCell {
    static let identifier = "AboutImageCell"
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        setSubviews(on: contentView, imageView)
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureCell(imageName: String) {
        setShadows()
        imageView.image = UIImage(named: imageName)
    }
    
    private func setShadows() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        layer.masksToBounds = false
        setViewShadows()
    }
    
    func showLogo(images count: Int) {
        imageView.image = UIImage(named: "20")
        setShadows()
        contentView.layer.cornerRadius = 25
        
        var logoImages: [UIImage] = []
        
        for image in 20..<count {
            logoImages.append(UIImage(named: "\(image)")!)
        }
        
        imageView.animationImages = logoImages
        imageView.animationDuration = 4
        imageView.animationRepeatCount = 50
        imageView.startAnimating()
    }
}

//
//  AboutImageCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 28.12.2021.
//

import UIKit

class AboutImageCell: UICollectionViewCell {
    
    static let identifier = "AboutImageCell"
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        contentView.backgroundColor = .red
    }
    
    private func setupConstraints() {
        
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
        
        layer.cornerRadius = 15
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
    }
    
    func showLogo(images count: Int) {
//        imageView.image = UIImage(named: "0")
        setShadows()
        
        contentView.layer.cornerRadius = 25
        var logoImages: [UIImage] = []
        
        for image in 0..<count {
            logoImages.append(UIImage(named: "\(image)")!)
        }
        
        imageView.animationImages = logoImages
        imageView.animationDuration = 20
        imageView.animationRepeatCount = 5
        imageView.startAnimating()
    }
}

//
//  SegmentedViewCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class SegmentedViewCell: UITableViewCell {
    static let identifier = "SegmentedViewCell"
    var callBack: ((Int) -> Void)?
    
    let ageSegmented: UISegmentedControl = {
        let segmented = UISegmentedControl()
        
        segmented.insertSegment(withTitle: "До 30 лет", at: 0, animated: false)
        segmented.insertSegment(withTitle: "30 - 40 лет", at: 1, animated: false)
        segmented.insertSegment(withTitle: "Свыше 40 лет", at: 2, animated: false)
        
        segmented.addTarget(self, action: #selector(segmentedSelected) , for: .valueChanged)
        return segmented
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        ageSegmented.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ageSegmented)
        
        NSLayoutConstraint.activate([
            ageSegmented.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            ageSegmented.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ageSegmented.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ageSegmented.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configure(_ age: TriathlonAgeCategory) {
        switch age {
            
        case .lessThirty:
            ageSegmented.selectedSegmentIndex = 0
            
        case .lessForty:
            ageSegmented.selectedSegmentIndex = 1
            
        case .moreForty:
            ageSegmented.selectedSegmentIndex = 2
        }
    }
    
    @objc func segmentedSelected() {
        guard let callBack = callBack else { return }
        callBack(ageSegmented.selectedSegmentIndex)
    }
    
}

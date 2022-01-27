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
    
    let ageSegmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl()
        
        segmented.insertSegment(withTitle: "До 30 лет", at: 0, animated: false)
        segmented.insertSegment(withTitle: "30 - 40 лет", at: 1, animated: false)
        segmented.insertSegment(withTitle: "Свыше 40 лет", at: 2, animated: false)
        
        segmented.addTarget(self, action: #selector(segmentSelected) , for: .valueChanged)
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
        setSubviews(on: contentView, ageSegmentedControl)
        
        NSLayoutConstraint.activate([
            ageSegmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            ageSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ageSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ageSegmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configure(_ age: TriathlonAgeCategory) {
        switch age {
        case .lessThirty:
            ageSegmentedControl.selectedSegmentIndex = 0
        case .lessForty:
            ageSegmentedControl.selectedSegmentIndex = 1
        case .moreForty:
            ageSegmentedControl.selectedSegmentIndex = 2
        }
    }
    
    @objc func segmentSelected() {
        guard let callBack = callBack else { return }
        callBack(ageSegmentedControl.selectedSegmentIndex)
    }
    
}

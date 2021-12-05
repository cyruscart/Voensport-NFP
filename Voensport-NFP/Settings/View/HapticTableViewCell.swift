//
//  HapticTableViewCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class HapticTableViewCell: UITableViewCell {
    
    private var hapticSwitch: UISwitch = {
        let hapticSwitch = UISwitch()
        hapticSwitch.value
        return hapticSwitch
    }()
    
    private var settingLabel: UILabel = {
        let label = UILabel()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        hapticSwitch.isOn = SettingsManager.shared.hapticOn
    }
    
    private func hapticSwitchChanged() {
        SettingsManager.shared.hapticOn.toggle()
        StorageManager.shared.saveSettings()
    }
    
}

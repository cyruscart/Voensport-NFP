//
//  NfpViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class NfpViewController: UIViewController  {
    
    var settings: Settings!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Сдача ФП"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(showSettings)
        )
    }
    
    @objc private func showSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.settings = settings
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

//
//  TabBarControllerFactory.swift
//  Voensport-NFP
//
//  Created by Кирилл on 12.01.2022.
//

import UIKit

struct TabBarControllerFactory {
    
    static func generate(settings: Settings) -> UITabBarController {
        let tabBarVC = UITabBarController()
        
        let nfpController = NfpController(settings: settings)
        let nfpViewController = NfpViewController(nfpController)
        let nfpTabBarImage = UIImage(named: "nfp")
        
        let sportListVC = SportListViewController()
        let sportTabBarImage = UIImage(named: "sport")
        
        let resultsVC = ResultsViewController()
        let resultTabBarImage = UIImage(systemName: "rectangle.stack.fill")
        
        let aboutAppVC = AboutAppViewController()
        let aboutTabBarImage = UIImage(systemName: "info.circle")
        
        tabBarVC.viewControllers = [
        generateNavigationController(rootViewController: nfpViewController, title: "Сдача ФП", image: nfpTabBarImage!),
        generateNavigationController(rootViewController: sportListVC, title: "Военный спорт", image: sportTabBarImage!),
        generateNavigationController(rootViewController: resultsVC, title: "Результаты", image: resultTabBarImage!),
        generateNavigationController(rootViewController: aboutAppVC, title: "О приложении", image: aboutTabBarImage!)
        ]
        return tabBarVC
    }
    
    static private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}


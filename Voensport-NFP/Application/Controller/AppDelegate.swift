//
//  AppDelegate.swift
//  Voensport-NFP
//
//  Created by Кирилл on 04.12.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var settings: Settings!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        settings = StorageManager.shared.getSettings()
        let mainTabBarVC = generateTabBarController(settings: settings)
       
        window?.rootViewController = mainTabBarVC
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveSettings(settings)
        
    }
// MARK: - Creating UITabBarController
    
    private func generateTabBarController(settings: Settings) -> UITabBarController {
        let tabBarVC = UITabBarController()
        
        let nfpViewController = NfpViewController()
        let nfpTabBarImage = UIImage(named: "nfp")
        nfpViewController.settings = settings
        
        let sportListVC = SportListViewController()
        let sportTabBarImage = UIImage(systemName: "sportscourt")
        
        tabBarVC.viewControllers = [
        generateNavigationController(rootViewController: nfpViewController, title: "Сдача ФП", image: nfpTabBarImage!),
        
        generateNavigationController(rootViewController: sportListVC, title: "Военный спорт", image: sportTabBarImage!)
        ]
        
        return tabBarVC
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        return navigationVC
    }
}

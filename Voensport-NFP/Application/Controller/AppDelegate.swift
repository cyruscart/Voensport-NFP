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
        
        let splashVC = SplashViewController()
        window?.rootViewController = splashVC
        
        settings = StorageManager.shared.getSettings()
        return true
    }
    
     func tabBarFactory() -> UITabBarController {
        
        let tabBarVC = UITabBarController()
        
        let nfpVC = NfpViewController()
        nfpVC.settings = settings
        
        let navController = UINavigationController(rootViewController: nfpVC)
        navController.tabBarItem.image = UIImage(named: "nfp")
        
        
        tabBarVC.modalPresentationStyle = .fullScreen
        
        tabBarVC.setViewControllers([navController], animated: false)
        
        
        return tabBarVC
        
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        StorageManager.shared.saveSettings(settings)
    }
}

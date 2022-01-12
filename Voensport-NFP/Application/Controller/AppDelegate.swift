//
//  AppDelegate.swift
//  Voensport-NFP
//
//  Created by Кирилл on 04.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var settings: Settings!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        settings = StorageManager.shared.getSettings()
        let mainTabBarVC = TabBarControllerFactory.generate(settings: settings)
        window?.rootViewController = mainTabBarVC
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        .portrait
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveSettings(settings)
    }

}

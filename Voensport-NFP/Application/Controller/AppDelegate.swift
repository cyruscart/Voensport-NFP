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
    
    private var settings: Settings?
    private var storage: StorageManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        storage = StorageManager()
        settings = storage?.fetch(key: .settings)
        
        let mainTabBarVC = TabBarControllerFactory.generate(settings: settings ?? Settings())
        window?.rootViewController = mainTabBarVC
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        .portrait
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if let settings = settings {
            storage?.save(object: settings, key: .settings)
        }
        
    }

}

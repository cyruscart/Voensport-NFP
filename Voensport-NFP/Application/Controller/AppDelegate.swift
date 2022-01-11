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
    private var resultsController: ResultsController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        settings = StorageManager.shared.getSettings()
        
        let mainTabBarVC = generateTabBarController(settings: settings)
        window?.rootViewController = mainTabBarVC
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        .portrait
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveSettings(settings)
    }
// MARK: - Creating UITabBarController
    
    private func generateTabBarController(settings: Settings) -> UITabBarController {
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
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

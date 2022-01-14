//
//  AppStoreReviewManager.swift
//  Voensport-NFP
//
//  Created by Кирилл on 14.01.2022.
//

import Foundation
import StoreKit

enum AppStoreReviewManager {
    static let minimumReviewWorthyActionCount = 3
    
    static func requestReview(in viewController: UIViewController) {
        var actionCount = StorageManager.shared.getReviewActionCount()
        actionCount += 1
        StorageManager.shared.setReviewActionCount(actionCount)
        
        guard actionCount >= minimumReviewWorthyActionCount else { return }
        guard let window = viewController.view.window?.windowScene else { return }
        
        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: bundleVersionKey) as? String
        let lastVersion = StorageManager.shared.getLastReviewRequestAppVersion()
        guard lastVersion == nil || lastVersion != currentVersion else { return }
        
        SKStoreReviewController.requestReview(in: window)
        
        StorageManager.shared.setReviewRequestAppVersion(currentVersion)
        
    }
    
}


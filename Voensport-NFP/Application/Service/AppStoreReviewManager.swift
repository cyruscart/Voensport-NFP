//
//  AppStoreReviewManager.swift
//  Voensport-NFP
//
//  Created by Кирилл on 14.01.2022.
//

import Foundation
import StoreKit

class AppStoreReviewManager {
    let minimumReviewWorthyActionCount = 10
    
    private var storage: AppStoreReviewStorageManager
    
    init() {
        self.storage = AppStoreReviewStorageManager()
    }
    
    
    func requestReview(in viewController: UIViewController) {
        var actionCount = storage.getReviewActionCount()
        actionCount += 1
        storage.setReviewActionCount(actionCount)
        
        guard actionCount >= minimumReviewWorthyActionCount else { return }
        guard let window = viewController.view.window?.windowScene else { return }
        
        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: bundleVersionKey) as? String
        let lastVersion = storage.getLastReviewRequestAppVersion()
        guard lastVersion == nil || lastVersion != currentVersion else { return }
        
        SKStoreReviewController.requestReview(in: window)
        
        storage.setReviewRequestAppVersion(currentVersion)
        
    }
    
}


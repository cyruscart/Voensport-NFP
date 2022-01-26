//
//  AppStoreReviewStorageManager.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class AppStoreReviewStorageManager {
    
    private var storage: StorageManager
    
    init() {
        self.storage = StorageManager()
    }
    
    func getReviewActionCount() -> Int {
        storage.fetch(for: .reviewWorthyActionCount)
    }
    
    func setReviewActionCount(_ value: Int) {
        storage.save(value, for: .reviewWorthyActionCount)
    }
    
    func setReviewRequestAppVersion(_ version: String?) {
        storage.save(version, for: .lastReviewRequestAppVersion)
    }
    
    func getLastReviewRequestAppVersion() -> String? {
        storage.fetch(for: .lastReviewRequestAppVersion)
    }
}

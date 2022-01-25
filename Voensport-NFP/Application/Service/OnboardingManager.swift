//
//  OnboardingManager.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class OnboardingManager {
    
    private var storage: StorageManager
    
    init(storage: StorageManager = StorageManager()) {
        self.storage = storage
    }
    
    func shouldShowOnboarding() -> Bool {
        !storage.isOnboardingShowed()
    }
}

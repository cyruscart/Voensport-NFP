//
//  StorageManager.swift
//  VoenSport
//
//  Created by Кирилл on 04.10.2021.
//

import Foundation


class StorageManager {
    
    private let storage = UserDefaults.standard
    
    enum StorageKey: String {
        case settings
        case results
        case onBoardingShowed
        case reviewWorthyActionCount
        case lastReviewRequestAppVersion
    }
    
    func save<T: Codable>(object: T, key: StorageKey) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        storage.set(data, forKey: key.rawValue)
    }
    
    func fetch<T: Codable>(key: StorageKey) -> T? {
        guard let data = storage.data(forKey: key.rawValue) else { return nil }
        guard let object = try? JSONDecoder().decode(T.self, from: data) else { return nil}
        
        return object
    }
    
    func fetch(for key: StorageKey) -> Int {
        storage.integer(forKey: key.rawValue)
    }
    
    func fetch(for key: StorageKey) -> String {
        storage.string(forKey: key.rawValue) ?? ""
    }
    
    func save<T>(_ value: T?, for key: StorageKey) {
        storage.set(value, forKey: key.rawValue)
    }

    func isOnboardingShowed() -> Bool {
            if let _ = storage.string(forKey: StorageKey.onBoardingShowed.rawValue) {
                return true
            } else {
                storage.set("showed", forKey: StorageKey.onBoardingShowed.rawValue)
                return false
            }
        }
}


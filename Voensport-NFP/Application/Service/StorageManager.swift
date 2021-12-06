//
//  StorageManager.swift
//  VoenSport
//
//  Created by Кирилл on 04.10.2021.
//

import Foundation


final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
 
    
    //MARK: - Settings
    
    func saveSettings(_ settings: Settings) {
        guard let data = try? JSONEncoder().encode(settings) else { return }
        
        UserDefaults.standard.set(data, forKey: "settings")
    }
    
    func getSettings() -> Settings {
        guard let data = UserDefaults.standard.data(forKey: "settings") else { return Settings() }
        guard let settings = try? JSONDecoder().decode(Settings.self, from: data) else { return Settings()}
        
        return settings
    }

}

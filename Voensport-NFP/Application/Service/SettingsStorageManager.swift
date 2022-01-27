//
//  SettingsStorageManager.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class SettingsStorageManager {
    private let storage: StorageManager

    init() {
        self.storage = StorageManager()
    }

    func save(_ settings: Settings) {
        storage.save(object: settings, key: .settings)
    }
    
    func fetch() -> Settings? {
        storage.fetch(key: .settings)
    }

}

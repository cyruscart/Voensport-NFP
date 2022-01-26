//
//  SettingsStorageManager.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class SettingsStorageManager {

    private var storage: StorageManager

    init(storage: StorageManager = StorageManager()) {
        self.storage = storage
    }

    func save(_ settings: Settings) {
        storage.save(object: settings, key: .settings)
    }
    
    func fetch() -> Settings? {
        storage.fetch(key: .settings)
    }

}

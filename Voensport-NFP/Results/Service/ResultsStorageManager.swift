//
//  ResultsStorageManager.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class ResultsStorageManager {
    
    private var storage: StorageManager
    
    init(storage: StorageManager = StorageManager()) {
        self.storage = storage
    }
    
    func deleteResult(for indexPath: IndexPath) {
        var resultsController = fetchResults()
        
        if indexPath.section == 0 {
            resultsController.nfpResults.remove(at: indexPath.row)
        } else {
            resultsController.sportResults.remove(at: indexPath.row)
        }
        
        storage.save(object: resultsController, key: .results)
    }
    
    
    func editSportResult(for indexPath: IndexPath, and sportResult: SportResult) {
        var resultsController = fetchResults()
        resultsController.sportResults[indexPath.row] = sportResult
        storage.save(object: resultsController, key: .results)
    }
    
    func editNfpResult(for indexPath: IndexPath, and nfpResult: NfpResult) {
        var resultsController = fetchResults()
        resultsController.nfpResults[indexPath.row] = nfpResult
        storage.save(object: resultsController, key: .results)
    }
    
    func saveNfpResult(result: NfpResult) {
        var resultsController = fetchResults()
        resultsController.nfpResults.insert(result, at: 0)
        storage.save(object: result, key: .results)
    }
    
    func saveSportResult(result: SportResult) {
        var resultsController = fetchResults()
        resultsController.sportResults.insert(result, at: 0)
        storage.save(object: result, key: .results)
    }
    
    func fetchResults() -> ResultsController {
        storage.fetch(key: .results) ?? ResultsController()
    }
}

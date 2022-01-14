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
    
    private enum Key: String {
        case settings
        case results
        case onBoardingShowed
        case reviewWorthyActionCount
        case lastReviewRequestAppVersion
    }
    
    //MARK: - Settings
    
    func saveSettings(_ settings: Settings) {
        guard let data = try? JSONEncoder().encode(settings) else { return }
        UserDefaults.standard.set(data, forKey: Key.settings.rawValue)
    }
    
    func fetchSettings() -> Settings {
        guard let data = UserDefaults.standard.data(forKey: Key.settings.rawValue) else { return Settings() }
        guard let settings = try? JSONDecoder().decode(Settings.self, from: data) else { return Settings()}
        
        return settings
    }
    
    //MARK: - Nfp
    
    func getNfpExercisesFromJsonFile(_ sex: Sex) -> [NfpExercise] {
        let jsonFileName = sex == .male ? "NfpManExercises" : "NfpWomanExercises"
        var exercises: [NfpExercise] = []
        
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
            do {
                guard let data = try String(contentsOfFile: path).data(using: .utf8) else { return exercises }
                exercises = try JSONDecoder().decode([NfpExercise].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return exercises
    }
    
    //MARK: - Sport
    
    func getSportExercisesFromJsonFile() -> (summerExercises: [TriathlonExercise], winterExercises: [TriathlonExercise]) {
        var summerExercises: [TriathlonExercise] = []
        var winterExercises: [TriathlonExercise] = []
        
        guard let winterPath = Bundle.main.path(forResource: "WinterTriathlonExercises", ofType: "json") else { return ([], []) }
        guard let summerPath = Bundle.main.path(forResource: "SummerTriathlonExercises", ofType: "json") else { return ([], []) }
        
        do {
            guard let summerData = try String(contentsOfFile: summerPath).data(using: .utf8) else { return ([], []) }
            summerExercises = try JSONDecoder().decode([TriathlonExercise].self, from: summerData)
            
            guard let winterData = try String(contentsOfFile: winterPath).data(using: .utf8) else { return ([], []) }
            winterExercises = try JSONDecoder().decode([TriathlonExercise].self, from: winterData)
        } catch {
            print(error.localizedDescription)
        }
        return(summerExercises, winterExercises)
    }
    
    //MARK: - Results
    
    func saveResults(results: ResultsController) {
        guard let data = try? JSONEncoder().encode(results) else { return }
        UserDefaults.standard.set(data, forKey: Key.results.rawValue)
    }
    
    func getResults() -> ResultsController {
        guard let data = UserDefaults.standard.data(forKey: Key.results.rawValue) else { return ResultsController() }
        guard let results = try? JSONDecoder().decode(ResultsController.self, from: data) else { return ResultsController() }
        return results
    }
    
    func deleteResult(with indexPath: IndexPath) {
        var resultsController = getResults()
        
        if indexPath.section == 0 {
            resultsController.nfpResults.remove(at: indexPath.row)
        } else {
            resultsController.sportResults.remove(at: indexPath.row)
        }
        
        saveResults(results: resultsController)
    }
    
    func editSportResult(with indexPath: IndexPath, and sportResult: SportResult) {
        var resultsController = getResults()
        resultsController.sportResults[indexPath.row] = sportResult
        saveResults(results: resultsController)
    }
    
    func editNfpResult(with indexPath: IndexPath, and nfpResult: NfpResult) {
        var resultsController = getResults()
        resultsController.nfpResults[indexPath.row] = nfpResult
        saveResults(results: resultsController)
    }
    
    //MARK: - Onboarding
    
    func shouldShowOnboarding() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: Key.onBoardingShowed.rawValue) {
            return false
        } else {
            UserDefaults.standard.set("showed", forKey: Key.onBoardingShowed.rawValue)
            return true
        }
    }
    
    //MARK: - AppReview
    
    func getReviewActionCount() -> Int {
        UserDefaults.standard.integer(forKey: Key.reviewWorthyActionCount.rawValue)
    }
    
    
    func setReviewActionCount(_ value: Int) {
        UserDefaults.standard.set(value, forKey: Key.reviewWorthyActionCount.rawValue)
    }
    
    func setReviewRequestAppVersion(_ version: String?) {
        UserDefaults.standard.set(version, forKey: Key.lastReviewRequestAppVersion.rawValue)
    }
    
    func getLastReviewRequestAppVersion() -> String? {
        UserDefaults.standard.string(forKey: Key.lastReviewRequestAppVersion.rawValue)
    }
}

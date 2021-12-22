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

//MARK: - Nfp
    
    func getNfpExercisesFromJsonFile(_ sex: Sex) -> [NfpExercise] {
        var exercises: [NfpExercise] = []
        
        let jsonFile = sex == .male ? "NfpManExercises" : "NfpWomanExercises"
        
        if let path = Bundle.main.path(forResource: jsonFile, ofType: "json") {
            do {
                guard let data = try String(contentsOfFile: path).data(using: .utf8) else { return exercises }
                exercises = try JSONDecoder().decode([NfpExercise].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            fatalError("File not found")
        }
        
        return exercises
    }
    
//MARK: - Sport
    
    func getSportExercisesFromJsonFile() -> (summerExercises: [SportExercise], winterExercises: [SportExercise]) {
        
        var summerExercises: [SportExercise] = []
        var winterExercises: [SportExercise] = []
        
        guard let winterPath = Bundle.main.path(forResource: "WinterTriathlonExercises", ofType: "json") else { return ([], []) }
        
        guard let summerPath = Bundle.main.path(forResource: "SummerTriathlonExercises", ofType: "json") else { return ([], []) }
        
        do {
            guard let summerData = try String(contentsOfFile: summerPath).data(using: .utf8) else { return ([], []) }
             summerExercises = try JSONDecoder().decode([SportExercise].self, from: summerData)
            
            guard let winterData = try String(contentsOfFile: winterPath).data(using: .utf8) else { return ([], []) }
             winterExercises = try JSONDecoder().decode([SportExercise].self, from: winterData)
            
        } catch {
            print(error.localizedDescription)
        }
        return(summerExercises, winterExercises )
        
    }
    
}

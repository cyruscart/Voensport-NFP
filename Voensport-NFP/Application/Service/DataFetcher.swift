//
//  DataFetcher.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class DataFetcher {
    
    func getDataFromJSON(file name: String) -> Data? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
        
        do {
            guard let data = try String(contentsOfFile: path).data(using: .utf8) else { return nil }
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    
    
    //    func getSportExercisesFromJsonFile() -> (summerExercises: [TriathlonExercise], winterExercises: [TriathlonExercise]) {
    //        var winterExercises: [TriathlonExercise] = []
    //
    //        guard let winterPath = Bundle.main.path(forResource: "WinterTriathlonExercises", ofType: "json") else { return ([], []) }
    //        guard let summerPath = Bundle.main.path(forResource: "SummerTriathlonExercises", ofType: "json") else { return ([], []) }
    //
    //        do {
    //            guard let summerData = try String(contentsOfFile: summerPath).data(using: .utf8) else { return ([], []) }
    //            summerExercises = try JSONDecoder().decode([TriathlonExercise].self, from: summerData)
    //
    //            guard let winterData = try String(contentsOfFile: winterPath).data(using: .utf8) else { return ([], []) }
    //            winterExercises = try JSONDecoder().decode([TriathlonExercise].self, from: winterData)
    //        } catch {
    //            print(error.localizedDescription)
    //        }
    //        return(summerExercises, winterExercises)
    //    }
    
}

//
//  SportDataFetcher.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class SportDataFetcher {
    
    private var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = DataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchSummerTriathlonExercises() -> [TriathlonExercise]? {
        guard let data = dataFetcher.getDataFromJSON(file: "SummerTriathlonExercises") else { return nil }
        
        guard let exercises = try? JSONDecoder().decode([TriathlonExercise].self, from: data) else {
            print("Exercises couldn't be encoded")
            return nil }
        
        return exercises
    }
    
    func fetchWinterTriathlonExercises() -> [TriathlonExercise]? {
        guard let data = dataFetcher.getDataFromJSON(file: "WinterTriathlonExercises") else { return nil }
        guard let exercises = try? JSONDecoder().decode([TriathlonExercise].self, from: data) else { return nil }
        
        return exercises
    }
}

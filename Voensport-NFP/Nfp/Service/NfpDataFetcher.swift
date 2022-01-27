//
//  NfpDataFetcher.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class NfpDataFetcher {
    
    private var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = DataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchNfpExercisesFromJsonFile(_ sex: Sex) -> [NfpExercise]? {
        let jsonFileName = sex == .male ? "NfpManExercises" : "NfpWomanExercises"
        
        guard let data = dataFetcher.getDataFromJSON(file: jsonFileName) else { return nil }
        
        guard let exercises = try? JSONDecoder().decode([NfpExercise].self, from: data) else {
            print("Exercises couldn't be encoded")
            return nil }
        
        return exercises
    }
    
}

//
//  ResultsController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 22.12.2021.
//

import Foundation


struct ResultsController: Codable {
    
    var nfpResults: [NfpResult] = []
    var sportResults: [SportResult] = []
    
    var shouldReloadData: Bool {
        nfpResults.isEmpty && sportResults.isEmpty
    }
    
    func getTitleForHeaderInSection(for section: Int) -> String {
        
        switch section {
        case 0:
            return nfpResults.isEmpty
            ? "Нет результатов сдачи ФП"
            : "Результаты сдачи ФП"
        default:
            return sportResults.isEmpty
            ? "Нет спортивных результатов"
            : "Спортивные результаты"
        }
    }
    

}
    
    
struct NfpResult: Codable {
    
    let totalScore: Int
    let grade: String
    let sex: Sex
    let maleAgeCategory: MaleAgeCategory
    let femaleAgeCategory: FemaleAgeCategory
    let numberOfExercise: NumberOfExercise
    let category: Category
    let date: Date
    let nfpExercises: [NfpExercise]
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        
        return dateFormatter.string(from: date)
    }
}

struct SportResult: Codable {
    
    let sportType: SportType
    let totalScore: Int
    let grade: String
    var date: Date
    
    var ageTriathlonCategory: TriathlonAgeCategory? = nil
    var triathlonType: TriathlonType? = nil
    
    var sportExercises: [TriathlonExercise] = []
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        
        return dateFormatter.string(from: date)
    }
}

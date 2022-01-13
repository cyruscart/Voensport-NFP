//
//  NfpResult.swift
//  Voensport-NFP
//
//  Created by Кирилл on 13.01.2022.
//

import Foundation

struct NfpResult: Codable {
    let totalScore: Int
    let grade: String
    let sex: Sex
    let maleAgeCategory: MaleAgeCategory
    let femaleAgeCategory: FemaleAgeCategory
    let numberOfExercise: NumberOfExercise
    let category: Category
    let date: String
    let nfpExercises: [NfpExercise]
    let tariff: Int
    
    func getExerciseForEditing() -> [[NfpExercise]] {
        var exercises: [[NfpExercise]] = []
        
        nfpExercises.forEach { exercise in
            exercises.append([exercise])
        }
        
        return exercises
    }
    
}

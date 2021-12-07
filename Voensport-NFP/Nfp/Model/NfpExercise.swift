//
//  NfpExercise.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import Foundation

enum ExerciseType: String, CaseIterable, Codable {
    case power = "Сила"
    case agility = "Ловкость"
    case speed = "Быстрота"
    case endurance = "Выносливость"
    case militarySkill = "Военно-прикладной навык"
}

struct NfpExercise: Codable {
    
    let number: String
    var name: String
    let type: ExerciseType
    var forWomanOlderThirty: Bool? = nil
    var forManOlderThirtyFive: Bool? = nil
    var exerciseDescription: String? = nil
    let scoreList: [String: Int]
    var score = 0
    
    var result: String? {
        scoreList.first(where: {$0.value == score})?.key ?? nil
    }
    
    
    func getScoreList() -> [Int] {
        scoreList.values.sorted()
    }
    
}

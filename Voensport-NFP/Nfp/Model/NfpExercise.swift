//
//  NfpExercise.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import Foundation

enum ExerciseType: String, CaseIterable, Codable, Hashable {
    case power = "Сила"
    case agility = "Ловкость"
    case speed = "Быстрота"
    case endurance = "Выносливость"
    case militarySkill = "Военно-прикладной навык"
}

class NfpExercise: Codable, Hashable {
    let number: String
    var name: String
    let type: ExerciseType
    var forWomanOlderThirty: Bool? = nil
    var forManOlderThirtyFive: Bool? = nil
    var exerciseDescription: String? = nil
    let scoreList: [String: Int]
    var score = 0
    private let identifier = UUID()
    
    var result: String? {
        scoreList.first(where: {$0.value == score})?.key ?? nil
    }
    
    init(number: String, name: String, type: ExerciseType, scoreList: [String: Int]) {
        self.number = number
        self.name = name
        self.scoreList = scoreList
        self.type = type
    }
    
    static func == (lhs: NfpExercise, rhs: NfpExercise) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func getScoreList() -> [Int] {
        scoreList.values.sorted()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
    
}

//
//  NfpExercise.swift
//  Voensport-NFP
//
//  Created by Кирилл on 07.12.2021.
//

import Foundation

final class NfpExercise: Codable {
    let number: String
    let type: ExerciseType
    let scoreList: [String: Int]
    
    var name: String
    var forWomanOlderThirty: Bool?
    var forManOlderThirtyFive: Bool?
    var exerciseDescription: String?
    var score = 0
    
    var result: String? {
        scoreList.first(where: {$0.value == score})?.key ?? nil
    }
    
    init(number: String, name: String, type: ExerciseType, scoreList: [String: Int]) {
        self.number = number
        self.name = name
        self.scoreList = scoreList
        self.type = type
    }
     
    func getScoreList() -> [Int] {
        scoreList.values.sorted()
    }
    
}

//
//  SportExercise.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import Foundation

final class TriathlonExercise: Codable {
    let name: String
    let triathlonAgeCategory: TriathlonAgeCategory
    let scoreList: [String: Int]
    var result = ""
    
    var score: Int {
        scoreList.first(where: {$0.key == result })?.value ?? 0
    }
    
    func getScoreList() -> [String] {
        Int(scoreList.keys.first!) != nil
        ? scoreList.keys.compactMap { Int($0) }.sorted().map { String($0) }
        : scoreList.keys.sorted()
    }
    
    func getIndexForEditingResult() -> Int {
        getScoreList().firstIndex(of: result) ?? 0
    }
}

//
//  SportResult.swift
//  Voensport-NFP
//
//  Created by Кирилл on 13.01.2022.
//

import Foundation

struct SportResult: Codable {
    let sportType: SportType
    let totalScore: Int
    let grade: String
    var date: String
    var ageTriathlonCategory: TriathlonAgeCategory? = nil
    var triathlonType: TriathlonType? = nil
    var sportExercises: [TriathlonExercise] = []
}

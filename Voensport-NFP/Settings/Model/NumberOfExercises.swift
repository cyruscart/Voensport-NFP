//
//  NumberOfExercises.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import Foundation

enum NumberOfExercise: String, CaseIterable, Codable {
    case three = "В трех упражнениях"
    case four = "В четырех упражнениях"
    case five = "В пяти упражнениях"
    
    func getIntegerNumberOfExercises() -> Int {
        switch self {
        case .three: return 3
        case .four: return 4
        case .five: return 5
        }
    }
}

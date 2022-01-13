//
//  SportGrade.swift
//  Voensport-NFP
//
//  Created by Кирилл on 18.12.2021.
//

import Foundation

enum SportType: String, CaseIterable, Codable {
    case summerTriathlon = "Летнее офицерское троеборье"
    case winterTriathlon = "Зимнее офицерское троеборье"
}

enum SportGrade: String, Codable {
    case ms = "Мастер спорта"
    case kms = "Кандидат в мастера спорта"
    case firstGrade = "1 разряд"
    case secondGrade = "2 разряд"
    case thirdGrade = "3 разряд"
    case withoutGrade = "Без разряда"
    
    static let paidSportGrade: [SportGrade] = [.ms, .kms, .firstGrade, .withoutGrade]
    
    static func getGradeFromText(grade: String) -> SportGrade {
        switch grade {
        case "1 разряд":
            return .firstGrade
        case "Кандидат в мастера спорта":
            return .kms
        case "Мастер спорта":
            return .ms
        default:
            return .withoutGrade
        }
    }
    
}



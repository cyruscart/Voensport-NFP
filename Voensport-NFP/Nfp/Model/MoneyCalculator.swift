//
//  MoneyCalculator.swift
//  Voensport-NFP
//
//  Created by Кирилл on 26.01.2022.
//

import Foundation

class MoneyCalculator {
    
    func calculate(grade: String, sportGrade: SportGrade, tariff: Int) -> String {
        guard let tariffMoney = Tariff.tariffs[String(tariff)] else { return "Tariff not found" }
        var money = 0
        
        switch grade {
        case "Высший уровень":
            if sportGrade == .ms {
                money = Int(tariffMoney * 0.87)
            } else if sportGrade == .kms {
                money = Int(tariffMoney * 0.9 * 0.87)
            } else if sportGrade == .firstGrade {
                money = Int(tariffMoney * 0.8 * 0.87)
            } else {
                money = Int(tariffMoney * 0.7 * 0.87)
            }
        case "1 уровень":
            money = Int(tariffMoney * 0.3 * 0.87)
        case "2 уровень":
            money = Int(tariffMoney * 0.15 * 0.87)
        default:
            money = 0
        }
        
        return String(money)
    }
}

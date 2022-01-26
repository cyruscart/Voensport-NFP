//
//  Grade.swift
//  Voensport-NFP
//
//  Created by Кирилл on 26.01.2022.
//

import Foundation

enum ExerciseType: String, CaseIterable, Codable {
    case power = "Сила"
    case agility = "Ловкость"
    case speed = "Быстрота"
    case endurance = "Выносливость"
    case militarySkill = "Военно-прикладной навык"
}

enum Grade: String, CaseIterable  {
    case highLevel = "Высший уровень"
    case firstLevel = "1 уровень"
    case secondLevel = "2 уровень"
    case five = "5"
    case four = "4"
    case three = "3"
    case two = "2"
}

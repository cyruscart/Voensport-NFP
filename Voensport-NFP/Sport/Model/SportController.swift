//
//  SportController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import Foundation

final class SportController {
    
    var isEditing = false
    var sportType: SportType = .triathlon
    var triathlonType: SportType.TriathlonType = .summer
    var ageCategory: SportType.TriathlonAgeCategory = .lessThirty
    var exercises: [SportExercise] = []
    
    var totalScore: Int {
        exercises.compactMap { $0.score }.reduce(0, +)
    }
    
    lazy var sportGrade = sportType == .triathlon
    ? calculateTriathlonGrade()
    : calculateVTGrade()
    
    
    
    //MARK: - Triathlon methods
    
//    func updateTriathlonExercises() {
//        
//        switch ageCategory {
//        case .lessThirty:
//            exercises = triathlonType == .summer
//            ? DataManager.shared.summerTriathlonExercises.filter {$0.triathlonAgeCategory == .lessThirty}
//            : DataManager.shared.winterTriathlonExercises.filter {$0.triathlonAgeCategory == .lessThirty}
//        case .lessForty:
//            exercises = triathlonType == .summer
//            ? DataManager.shared.summerTriathlonExercises.filter {$0.triathlonAgeCategory == .lessForty}
//            : DataManager.shared.winterTriathlonExercises.filter {$0.triathlonAgeCategory == .lessForty}
//        case .moreForty:
//            exercises = triathlonType == .summer
//            ? DataManager.shared.summerTriathlonExercises.filter {$0.triathlonAgeCategory == .moreForty}
//            : DataManager.shared.winterTriathlonExercises.filter {$0.triathlonAgeCategory == .moreForty}
//        }
//    }
//    
    
    func calculateTriathlonGrade() -> String {
        var grade = ""
        
        switch totalScore {
        case 2800...:
            if exercises.filter({$0.score! < 600}).isEmpty {
                grade = SportGrade.ms.rawValue
            } else if exercises.filter({$0.score! < 500}).isEmpty {
                grade = SportGrade.kms.rawValue
            } else if exercises.filter({$0.score! < 400}).isEmpty {
                grade = SportGrade.firstGrade.rawValue
            } else if exercises.filter({$0.score! < 300}).isEmpty {
                grade = SportGrade.secondGrade.rawValue
            } else if exercises.filter({$0.score! < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        case 2600...2799:
            if exercises.filter({$0.score! < 500}).isEmpty {
                grade = SportGrade.kms.rawValue
            } else if exercises.filter({$0.score! < 400}).isEmpty {
                grade = SportGrade.firstGrade.rawValue
            } else if exercises.filter({$0.score! < 300}).isEmpty {
                grade = SportGrade.secondGrade.rawValue
            } else if exercises.filter({$0.score! < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        case 2300...2599:
            if exercises.filter({$0.score! < 400}).isEmpty {
                grade = SportGrade.firstGrade.rawValue
            } else if exercises.filter({$0.score! < 300}).isEmpty {
                grade = SportGrade.secondGrade.rawValue
            } else if exercises.filter({$0.score! < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        case 2100...2299:
            if exercises.filter({$0.score! < 300}).isEmpty {
                grade = SportGrade.secondGrade.rawValue
            } else if exercises.filter({$0.score! < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        case 1700...2099:
            if exercises.filter({$0.score! < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        default:
            break
        }
        return grade
    }
    
    //MARK: - VT methods
    
    func calculateVTGrade() -> String {
        var grade = ""
        
        if !exercises.filter({$0.score == nil}).isEmpty {
            return " " // пробел для отслеживания момента, когда показывать кнопку сохранить
        }
        
        switch totalScore {
        case 2900...:
            grade = SportGrade.kms.rawValue
        case 2300...2899:
            grade = SportGrade.firstGrade.rawValue
        case 1800...2299:
            grade = SportGrade.secondGrade.rawValue
        case 1400...1799:
                grade = SportGrade.thirdGrade.rawValue
        default:
            break
        }
        return grade
    }
    
    func getExerciseTitleForSegment(_ index: Int) -> [String] {
        switch index {
        case 0:
            return ["Подтягивания", "Подъем переворотом"]
        case 1:
            return ["Бег 60 м", "Бег 100 м"]
        case 2:
            return ["Бег 1 км", "Бег 3 км"]
        default:
            return ["ПП ОКУ", "ПП ВМФ", "Лопинг"]
        }
    }
    
   
}

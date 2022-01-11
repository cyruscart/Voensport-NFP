//
//  TriathlonController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

final class TriathlonController {
    var triathlonType: TriathlonType = .summer
    var isEditing = false
    var editingResultIndex = IndexPath()
    var editingResultDate = ""
    var ageCategory: TriathlonAgeCategory = .lessThirty
    var exercises: [TriathlonExercise] = []
    
    var date: String {
        isEditing ? editingResultDate : getDate()
    }
    
    var sportType: SportType {
        triathlonType == .summer ? .summerTriathlon : .winterTriathlon
    }
    
    var totalScore: Int {
        exercises.compactMap { $0.score }.reduce(0, +)
    }
    
    private var summerTriathlonExercises: [TriathlonExercise] = []
    private var winterTriathlonExercises: [TriathlonExercise] = []
    
    init(sportResult: SportResult) {
        exercises = sportResult.sportExercises
        isEditing = true
        triathlonType = sportResult.triathlonType ?? .summer
        ageCategory = sportResult.ageTriathlonCategory ?? .lessForty
    }
    
    init() {}
    
    //MARK: - Initial data methods
    
    func updateTriathlonExercises() {
        if !isEditing {
            let sportExercises = StorageManager.shared.getSportExercisesFromJsonFile()
            summerTriathlonExercises = sportExercises.summerExercises
            winterTriathlonExercises = sportExercises.winterExercises
            
            switch ageCategory {
            case .lessThirty:
                exercises = triathlonType == .summer
                ? summerTriathlonExercises.filter {$0.triathlonAgeCategory == .lessThirty}
                : winterTriathlonExercises.filter {$0.triathlonAgeCategory == .lessThirty}
            case .lessForty:
                exercises = triathlonType == .summer
                ? summerTriathlonExercises.filter {$0.triathlonAgeCategory == .lessForty}
                : winterTriathlonExercises.filter {$0.triathlonAgeCategory == .lessForty}
            case .moreForty:
                exercises = triathlonType == .summer
                ? summerTriathlonExercises.filter {$0.triathlonAgeCategory == .moreForty}
                : winterTriathlonExercises.filter {$0.triathlonAgeCategory == .moreForty}
            }
        }
    }
    
    //MARK: - Return data methods
    
    func shouldShowTotalScore() -> Bool {
        exercises.filter { $0.score == 0 }.count < 3
    }
    
    func generateSportResult() -> SportResult {
        SportResult(
            sportType: sportType,
            totalScore: totalScore,
            grade: calculateTriathlonGrade(),
            date: date,
            ageTriathlonCategory: ageCategory,
            triathlonType: triathlonType,
            sportExercises: exercises
        )
    }
    
    private func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        return dateFormatter.string(from: Date())
    }
    
    //MARK: - Calculation methods
    
    func calculateTriathlonGrade() -> String {
        switch ageCategory {
        case .lessThirty:
            return calculateLessThirtyGrade()
        case .lessForty:
            return calculateLessFortyGrade()
        case .moreForty:
            return calculateMoreFortyGrade()
        }
    }
    
    private func calculateLessThirtyGrade() -> String {
        switch totalScore {
        case 2800...:
            return calculateMS()
        case 2600...2799:
            return calculateKMS()
        case 2300...2599:
            return calculateFirstGrade()
        case 2100...2299:
            return calculateSecondGrade()
        case 1700...2099:
            return calculateThirdGrade()
        default:
            return ""
        }
    }
    
    private func calculateLessFortyGrade() -> String {
        switch totalScore {
        case 2800...:
            return calculateMS()
        case 2600...2799:
            return calculateKMS()
        case 2200...2599:
            return calculateFirstGrade()
        case 2000...2199:
            return calculateSecondGrade()
        case 1600...1999:
            return calculateThirdGrade()
        default:
            return ""
        }
    }
    
    private func calculateMoreFortyGrade() -> String {
        switch totalScore {
        case 2800...:
            return calculateMS()
        case 2600...2799:
            return calculateKMS()
        case 2000...2599:
            return calculateFirstGrade()
        case 1900...1999:
            return calculateSecondGrade()
        case 1500...1899:
            return calculateThirdGrade()
        default:
            return ""
        }
    }
    
    private func calculateMS() -> String {
        if exercises.filter({$0.score < 600}).isEmpty {
            return SportGrade.ms.rawValue
        } else if exercises.filter({$0.score < 500}).isEmpty {
            return SportGrade.kms.rawValue
        } else if exercises.filter({$0.score < 400}).isEmpty {
            return SportGrade.firstGrade.rawValue
        } else if exercises.filter({$0.score < 300}).isEmpty {
            return SportGrade.secondGrade.rawValue
        } else if exercises.filter({$0.score < 200}).isEmpty {
            return SportGrade.thirdGrade.rawValue
        } else {
            return ""
        }
    }
    
    private func calculateKMS() -> String {
        if exercises.filter({$0.score < 500}).isEmpty {
            return SportGrade.kms.rawValue
        } else if exercises.filter({$0.score < 400}).isEmpty {
            return SportGrade.firstGrade.rawValue
        } else if exercises.filter({$0.score < 300}).isEmpty {
            return SportGrade.secondGrade.rawValue
        } else if exercises.filter({$0.score < 200}).isEmpty {
            return SportGrade.thirdGrade.rawValue
        } else {
            return ""
        }
    }
    
    private func calculateFirstGrade() -> String {
        if exercises.filter({$0.score < 400}).isEmpty {
            return SportGrade.firstGrade.rawValue
        } else if exercises.filter({$0.score < 300}).isEmpty {
            return SportGrade.secondGrade.rawValue
        } else if exercises.filter({$0.score < 200}).isEmpty {
            return SportGrade.thirdGrade.rawValue
        } else {
            return ""
        }
    }
    
    private func calculateSecondGrade() -> String {
        if exercises.filter({$0.score < 300}).isEmpty {
            return SportGrade.secondGrade.rawValue
        } else if exercises.filter({$0.score < 200}).isEmpty {
            return SportGrade.thirdGrade.rawValue
        } else {
            return ""
        }
    }
    
    private func calculateThirdGrade() -> String {
        if exercises.filter({$0.score < 200}).isEmpty {
            return SportGrade.thirdGrade.rawValue
        } else {
            return ""
        }
    }
    
}


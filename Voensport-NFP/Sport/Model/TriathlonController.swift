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
    
    var date: String {
        isEditing ? editingResultDate : getDate()
    }
    
    var editingResultIndex = IndexPath()
    var editingResultDate = ""
    
    var sportType: SportType {
        triathlonType == .summer ? .summerTriathlon : .winterTriathlon
    }
    
    var ageCategory: TriathlonAgeCategory = .lessThirty
    var exercises: [TriathlonExercise] = []
    
    private var summerTriathlonExercises: [TriathlonExercise] = []
    private var winterTriathlonExercises: [TriathlonExercise] = []
    
    var totalScore: Int {
        exercises.compactMap { $0.score }.reduce(0, +)
    }
    
    init(sportResult: SportResult) {
        exercises = sportResult.sportExercises
        isEditing = true
        triathlonType = sportResult.triathlonType ?? .summer
        ageCategory = sportResult.ageTriathlonCategory ?? .lessForty
        print("TriathlonVC has been allocated")
    }
    
    init() {}
    deinit { print("TriathlonVC has been deallocated")}
    
    //MARK: - Triathlon methods
    
    private func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        return dateFormatter.string(from: Date())
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
    
    func calculateTriathlonGrade() -> String {
        var grade = ""
        
        switch totalScore {
        case 2800...:
            if exercises.filter({$0.score < 600}).isEmpty {
                grade = SportGrade.ms.rawValue
            } else if exercises.filter({$0.score < 500}).isEmpty {
                grade = SportGrade.kms.rawValue
            } else if exercises.filter({$0.score < 400}).isEmpty {
                grade = SportGrade.firstGrade.rawValue
            } else if exercises.filter({$0.score < 300}).isEmpty {
                grade = SportGrade.secondGrade.rawValue
            } else if exercises.filter({$0.score < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        case 2600...2799:
            if exercises.filter({$0.score < 500}).isEmpty {
                grade = SportGrade.kms.rawValue
            } else if exercises.filter({$0.score < 400}).isEmpty {
                grade = SportGrade.firstGrade.rawValue
            } else if exercises.filter({$0.score < 300}).isEmpty {
                grade = SportGrade.secondGrade.rawValue
            } else if exercises.filter({$0.score < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        case 2300...2599:
            if exercises.filter({$0.score < 400}).isEmpty {
                grade = SportGrade.firstGrade.rawValue
            } else if exercises.filter({$0.score < 300}).isEmpty {
                grade = SportGrade.secondGrade.rawValue
            } else if exercises.filter({$0.score < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        case 2100...2299:
            if exercises.filter({$0.score < 300}).isEmpty {
                grade = SportGrade.secondGrade.rawValue
            } else if exercises.filter({$0.score < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        case 1700...2099:
            if exercises.filter({$0.score < 200}).isEmpty {
                grade = SportGrade.kms.rawValue
            }
        default:
            break
        }
        return grade
    }
    
    func shouldShowTotalScore() -> Bool {
        exercises.filter { $0.score == 0 }.count < 3
    }
}


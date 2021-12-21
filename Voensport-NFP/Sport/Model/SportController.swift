//
//  SportController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import Foundation

final class SportController {
    
    var isEditing = false
    var triathlonType: SportType.TriathlonType = .summer
    var ageCategory: SportType.TriathlonAgeCategory = .lessThirty
    var exercises: [SportExercise] = []
    private var summerTriathlonExercises: [SportExercise] = []
    private var winterTriathlonExercises: [SportExercise] = []
    
    var totalScore: Int {
        exercises.compactMap { $0.score }.reduce(0, +)
    }
    
    lazy var sportGrade = calculateTriathlonGrade()
    
    
     func loadExercises() {
        
        guard let summerPath = Bundle.main.path(forResource: "SummerTriathlonExercises", ofType: "json") else { return }
        guard let winterPath = Bundle.main.path(forResource: "WinterTriathlonExercises", ofType: "json") else { return }
        
            do {
                guard let summerData = try String(contentsOfFile: summerPath).data(using: .utf8) else { return }
                summerTriathlonExercises = try JSONDecoder().decode([SportExercise].self, from: summerData)
                
                guard let winterData = try String(contentsOfFile: winterPath).data(using: .utf8) else { return }
                summerTriathlonExercises = try JSONDecoder().decode([SportExercise].self, from: winterData)
                
            } catch {
                print(error.localizedDescription)
            }
    }
    
    //MARK: - Triathlon methods
    
    func updateTriathlonExercises() {
        exercises.removeAll()
        loadExercises()
        
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
    
}

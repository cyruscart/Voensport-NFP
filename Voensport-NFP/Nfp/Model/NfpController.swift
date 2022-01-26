//
//  NfpController.swift
//  VoenSport
//
//  Created by Кирилл on 11.10.2021.
//

import Foundation

final class NfpController {
    let settings: Settings
    let nfpCalculator: NfpCalculator
    
    var exercises: [[NfpExercise]] = []
    var selectedExercises: [NfpExercise] = []
    var isEditing = false
    var editingResultIndex = IndexPath()
    var editingResultDate = ""
    
    private let dataFetcher: NfpDataFetcher
    
    var date: String {
        return isEditing ? editingResultDate : getDate()
    }
    
    var totalScore: Int {
        selectedExercises.map { $0.score }.reduce(0, +)
    }
    
    init(settings: Settings) {
        self.settings = settings
        dataFetcher = NfpDataFetcher()
        nfpCalculator = NfpCalculator()
        nfpCalculator.settings = settings
    }
    
    //MARK: - Initial data methods
    
    func loadInitialData() {
        if !isEditing {
            loadExercises()
        }
        loadInitialSelectedExercise()
    }
    
    private func loadInitialSelectedExercise() {
        selectedExercises = []
        exercises.forEach { exercises in
            if let exercise = exercises.first {
                selectedExercises.append(exercise)
            }
        }
    }
    
    private func loadExercises() {
        var exerciseTypes: [ExerciseType] = [.speed, .power, .endurance, .militarySkill, .agility]
        var exercisesList: [[NfpExercise]] = []
        
        for _ in 1...settings.getIntegerNumberOfExercises() {
            guard let exercisesFromJSON = dataFetcher.fetchNfpExercisesFromJsonFile(settings.sex) else { return }
            var exercises: [NfpExercise] = []
            
            exerciseTypes.forEach { type in
                if settings.sex == .male {
                    exercises.append(contentsOf: exercisesFromJSON.filter { $0.type == type })
                    
                    exercises = settings.isManOlderThirtyFive
                    ? exercises.filter { $0.forManOlderThirtyFive != false }
                    : exercises.filter { $0.forManOlderThirtyFive != true }
                } else {
                    exercises.append(contentsOf: exercisesFromJSON.filter { $0.type == type })
                    
                    exercises = settings.isWomanOlderThirty
                    ? exercises.filter { $0.forWomanOlderThirty != false }
                    : exercises.filter { $0.forWomanOlderThirty != true }
                }
            }
            let changingType = exerciseTypes.removeFirst()
            exerciseTypes.append(changingType)
            exercisesList.append(exercises)
        }
        exercises = exercisesList
    }
    
    
    //MARK: - Return data methods
    
    func generateNfpResult() -> NfpResult {
        NfpResult(totalScore: totalScore,
                  grade: calculateGrade(),
                  sex: settings.sex,
                  maleAgeCategory: settings.maleAgeCategory,
                  femaleAgeCategory: settings.femaleAgeCategory,
                  numberOfExercise: settings.numberOfExercise,
                  category: settings.category,
                  date: date,
                  nfpExercises: selectedExercises,
                  tariff: settings.tariff)
    }
    
    func getGradeForTotalScoreLabel() -> String {
        if calculateGrade() == Grade.highLevel.rawValue ||
            calculateGrade() == Grade.firstLevel.rawValue ||
            calculateGrade() == Grade.secondLevel.rawValue {
            return calculateGrade()
        } else {
            return ""
        }
    }
    
    func getMarkForTotalScoreLabel() -> String {
        if calculateGrade() == Grade.highLevel.rawValue ||
            calculateGrade() == Grade.firstLevel.rawValue ||
            calculateGrade() == Grade.secondLevel.rawValue ||
            calculateGrade() == Grade.five.rawValue {
            return "5"
        } else {
            return calculateGrade()
        }
    }
    
    func getMinimumScore(for exercise: NfpExercise) -> Int {
        prepareCalculating()
        return exercise.getScoreList().filter { $0 >= nfpCalculator.minimumScore }.first ?? nfpCalculator.minimumScore
    }
    
    func getTitleForSection(with section: Int) -> String {
        section == settings.getIntegerNumberOfExercises()
        ? ""
        : "\(["1 упражнение", "2 упражнение", "3 упражнение", "4 упражнение", "5 упражнение"][section])"
    }
    
    private func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        return dateFormatter.string(from: Date())
    }
    
    //MARK: - Base calculation methods
    
    func prepareCalculating() {
        nfpCalculator.settings = settings
    }
    
    func calculateGrade() -> String {
        prepareCalculating()
        
        if !selectedExercises.filter({ $0.score < nfpCalculator.minimumScore }).isEmpty {
            return Grade.two.rawValue
        }
        
        return nfpCalculator.getGrade(totalScore: totalScore)
        
    }
    
    func shouldCalculateMoney() -> Bool {
        nfpCalculator.getGrade(totalScore: totalScore) == "Высший уровень"
        || calculateGrade() == "1 уровень"
        || calculateGrade() == "2 уровень"
    }
    
    func getAmountOfMoney() -> String {
        guard let tariff = Tariff.tariff[String(settings.tariff)] else { return "tariff not found" }
        var money = 0
        
        switch calculateGrade() {
        case "Высший уровень":
            if settings.sportGrade == .ms {
                money = Int(tariff * 0.87)
            } else if settings.sportGrade == .kms {
                money = Int(tariff * 0.9 * 0.87)
            } else if settings.sportGrade == .firstGrade {
                money = Int(tariff * 0.8 * 0.87)
            } else {
                money = Int(tariff * 0.7 * 0.87)
            }
        case "1 уровень":
            money = Int(tariff * 0.3 * 0.87)
        case "2 уровень":
            money = Int(tariff * 0.15 * 0.87)
        default:
            money = 0
        }
        
        return String(money)
    }
}


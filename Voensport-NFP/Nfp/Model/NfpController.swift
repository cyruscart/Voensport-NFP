//
//  NfpController.swift
//  VoenSport
//
//  Created by Кирилл on 11.10.2021.
//

import Foundation

final class NfpController {
    let settings: Settings
    let nfpCalculator = NfpCalculator()
    let moneyCalculator = MoneyCalculator()
    let nfpExercisesManager = NfpExercisesManager()
    
    var exercises: [[NfpExercise]] = []
    var selectedExercises: [NfpExercise] = []
    var isEditing = false
    var editingResultIndex = IndexPath()
    var editingResultDate = ""
    
    var date: String {
        return isEditing ? editingResultDate : getDate()
    }
    
    var totalScore: Int {
        selectedExercises.map { $0.score }.reduce(0, +)
    }
    
    init(settings: Settings) {
        self.settings = settings
        nfpCalculator.settings = settings
    }
    
    //MARK: - Initial data methods
    
    func loadInitialData() {
        if !isEditing {
            exercises = nfpExercisesManager.getExercises(settings)
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
        moneyCalculator.calculate(grade: calculateGrade(), sportGrade: settings.sportGrade, tariff: settings.tariff)
}
    
}

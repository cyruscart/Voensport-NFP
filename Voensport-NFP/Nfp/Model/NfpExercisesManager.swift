//
//  NfpExercisesManager.swift
//  Voensport-NFP
//
//  Created by Кирилл on 01.02.2022.
//

import Foundation

class NfpExercisesManager {
    private let storage = ResultsStorageManager()
    private let dataFetcher = NfpDataFetcher()
    
    func getExercises(_ settings: Settings) -> [[NfpExercise]] {
        var exerciseTypes: [ExerciseType] = [.speed, .power, .endurance, .militarySkill, .agility]
        var exercisesList: [[NfpExercise]] = []
        
        for _ in 1...settings.numberOfExercise.getIntegerNumberOfExercises() {
            guard let exercisesFromJSON = dataFetcher.fetchNfpExercisesFromJsonFile(settings.sex) else { return []}
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

        return isLastSettingsEqualCurrent(settings)
        ? sortedExercises(exercisesList)
        : exercisesList
    }
    
    private func sortedExercises(_ exercises: [[NfpExercise]]) -> [[NfpExercise]] {
        guard let nfpResult = storage.fetchResults().nfpResults.first else { return exercises}
        var sortedExercises = exercises
        let lastExercises = nfpResult.nfpExercises
        
        for exerciseIndex in 0..<exercises.count {
            let lastExercise = lastExercises[exerciseIndex]
            var oneTypeExercises = exercises[exerciseIndex]
            
            guard let needExerciseIndex = (oneTypeExercises.firstIndex { $0.name == lastExercise.name }) else { return exercises }
            oneTypeExercises.remove(at: needExerciseIndex)
            lastExercise.score = 0
            
            oneTypeExercises.insert(lastExercise, at: 0)
            sortedExercises[exerciseIndex] = oneTypeExercises
        }
        return sortedExercises
        
    }
    
    private func fetchLastNfpResult() -> NfpResult? {
        let resultController = storage.fetchResults()
        return resultController.nfpResults.first
    }
    
    private func isLastSettingsEqualCurrent(_ settings: Settings) -> Bool {
        guard let nfpResult = storage.fetchResults().nfpResults.first else { return false}
        
        return settings.sex == nfpResult.sex &&
        settings.numberOfExercise == nfpResult.numberOfExercise &&
        settings.maleAgeCategory == nfpResult.maleAgeCategory &&
        settings.femaleAgeCategory == nfpResult.femaleAgeCategory
        
    }
    
}



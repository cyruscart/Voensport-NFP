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
        
        for _ in 1...settings.getIntegerNumberOfExercises() {
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
        
        // exerciseIndex - индекс массива упражнений одного типа
        
        for exerciseIndex in 0..<exercises.count {
            // упражнение из последнего сохраненного результата
            let lastExercise = lastExercises[exerciseIndex]
            // массив упражнений одного типа
            var oneTypeExercises = exercises[exerciseIndex]
            // индекс нужного упражнения в массиве
            guard let needExerciseIndex = (oneTypeExercises.firstIndex { $0.name == lastExercise.name }) else { return exercises }
            // удаление нужного упражнения из массива
            oneTypeExercises.remove(at: needExerciseIndex)
            // установка дефолтного значения score
            lastExercise.score = 0
            // вставка упражнения в начало массива упражнений одного типа
            oneTypeExercises.insert(lastExercise, at: 0)
            // замена полученного массива упражнений одного типа
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



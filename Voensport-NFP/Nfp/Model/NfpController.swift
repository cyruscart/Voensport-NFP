//
//  ManPerfomance.swift
//  VoenSport
//
//  Created by Кирилл on 11.10.2021.
//

import Foundation

final class NfpController {
    
    var settings: Settings
    var exercises: [[NfpExercise]] = []
    var selectedExercises: [NfpExercise] = []
    
    var isEditing = false
    //    var editingPerformance = PerformanceResult(totalScore: 0, grade: "", date: Date())
    
    var maleAgeCategory: MaleAgeCategory {
        //        isEditing
        //        ? editingPerformance.maleAgeCategory!
        //        : settings.maleAgeCategory
        settings.maleAgeCategory
    }
    
    var femaleAgeCategory: FemaleAgeCategory {
        //        isEditing
        //        ? editingPerformance.femaleAgeCategory!
        //        : settings.femaleAgeCategory
        settings.femaleAgeCategory
    }
    
    var category: Category {
        //        isEditing
        //        ? editingPerformance.category!
        //        : settings.category
        settings.category
    }
    
    var numberOfExercise: NumberOfExercise {
        //        isEditing
        //        ? editingPerformance.numberOfExercise!
        //        : settings.numberOfExercise
        settings.numberOfExercise
    }
    
    var totalScore: Int {
        selectedExercises.map { $0.score }.reduce(0, +)
    }
    
    
    var minimumScore: Int {
        
        if settings.sex == .male {
            
            switch maleAgeCategory {
            case .candidate:
                return 26
            case .solderLessSixMonths:
                return 26
            case .solderMoreSixMonths:
                return 28
            case .cadetFirstYear:
                return 28
            case .cadetSecondYear:
                return 30
            case .cadetThirdYearAndOlder:
                return 32
            case .firstAgeGroup:
                return 30
            case .secondAgeGroup:
                return 28
            case .thirdAgeGroup:
                return 24
            case .fourthAgeGroup:
                return 22
            case .fifthAgeGroup:
                return 20
            case .sixthAgeGroup:
                return 16
            case .seventhAgeGroup:
                return 12
            case .eighthAgeGroup:
                return 6
            }
            
        } else {
            
            switch femaleAgeCategory {
            case .candidate:
                return 26
            case .firstAgeGroup:
                return 28
            case .secondAgeGroup:
                return 26
            case .thirdAgeGroup:
                return 24
            case .fourthAgeGroup:
                return 22
            case .fifthAgeGroup:
                return 20
            case .sixthAgeGroup:
                return 18
            }
        }
    }
    
    private enum Grade: String, CaseIterable  {
        case highLevel = "Высший уровень"
        case firstLevel = "1 уровень"
        case secondLevel = "2 уровень"
        case five = "5"
        case four = "4"
        case three = "3"
        case two = "2"
    }
    
    init(settings: Settings) {
        self.settings = settings
    }
    
    //MARK: - Methods
    func loadInitialData() {
        loadExercises()
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
            let exercisesFromJSON = getExercisesFromJsonFile()
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
            
            let changingType = exerciseTypes.removeFirst() // криво
            exerciseTypes.append(changingType)
            
            exercisesList.append(exercises)
        }
        exercises = exercisesList
    }
    
    private func getExercisesFromJsonFile() -> [NfpExercise] {
        var exercises: [NfpExercise] = []
        
        let jsonFile = settings.sex == .male
        ? "NfpManExercises"
        : "NfpWomanExercises"
        
        if let path = Bundle.main.path(forResource: jsonFile, ofType: "json") {
            do {
                guard let data = try String(contentsOfFile: path).data(using: .utf8) else { return exercises }
                exercises = try JSONDecoder().decode([NfpExercise].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            fatalError("File not found")
        }
        
        return exercises
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
        exercise.getScoreList().filter { $0 >= minimumScore }.first ?? minimumScore
    }
    
    func getTitleForSection(with section: Int) -> String {
        section == settings.getIntegerNumberOfExercises()
        ? ""
        : "\(["1 упражнение", "2 упражнение", "3 упражнение", "4 упражнение", "5 упражнение"][section])"
    }
    
    
    func calculateGrade() -> String {
        
        if !selectedExercises.filter({ $0.score < minimumScore }).isEmpty {
            return Grade.two.rawValue
        }
        
        if settings.sex == .male {
            
            switch maleAgeCategory {
            case .candidate: return
                calculateCandidateGrade()
            case .solderLessSixMonths:
                return calculateLessSixMonthGrade()
            case .solderMoreSixMonths:
                return calculateMoreSixMonthGrade()
            case .cadetFirstYear:
                return calculateCadetFirstYearGrade()
            case .cadetSecondYear:
                return calculateCadetSecondYearGrade()
            case .cadetThirdYearAndOlder:
                return calculateCadetThirdYearGrade()
            case .firstAgeGroup:
                return calculateFirstGroupGrade()
            case .secondAgeGroup:
                return calculateSecondGroupGrade()
            case .thirdAgeGroup:
                return calculateThirdGroupGrade()
            case .fourthAgeGroup:
                return calculateFourthGroupGrade()
            case .fifthAgeGroup:
                return calculateFifthGroupGrade()
            case .sixthAgeGroup:
                return calculateSixthGroupGrade()
            case .seventhAgeGroup:
                return calculateSeventhGroupGrade()
            case .eighthAgeGroup:
                return calculateEighthGroupGrade()
            }
            
        } else {
            
            switch femaleAgeCategory {
            case .candidate:
                return calculateWomanCandidateGrade()
            case .firstAgeGroup:
                return calculateWomanFirstGroupGrade()
            case .secondAgeGroup:
                return calculateWomanSecondGroupGrade()
            case .thirdAgeGroup:
                return calculateWomanThirdGroupGrade()
            case .fourthAgeGroup:
                return calculateWomanFourthGroupGrade()
            case .fifthAgeGroup:
                return calculateWomanFifthGroupGrade()
            case .sixthAgeGroup:
                return calculateWomanSixthGroupGrade()
            }
        }
    }
    
    //MARK: - Private methods for man
    
    private func calculateCandidateGrade() -> String {
        var localGrade = ""
        
        switch numberOfExercise {
        case .three:
            switch totalScore {
            case 120...149:
                localGrade = Grade.three.rawValue
            case 150...169:
                localGrade = Grade.four.rawValue
            case 170...:
                localGrade = Grade.five.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .four:
            switch totalScore {
            case 170...209:
                localGrade = Grade.three.rawValue
            case 210...229:
                localGrade = Grade.four.rawValue
            case 230...:
                localGrade = Grade.five.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        default:
            break
        }
        return localGrade
    }
    
    private func calculateLessSixMonthGrade() -> String {
        var localGrade = ""
        
        switch numberOfExercise {
        case .three:
            switch totalScore {
            case 100...129:
                localGrade = Grade.three.rawValue
            case 130...159:
                localGrade = Grade.four.rawValue
            case 160...:
                localGrade = Grade.five.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .four:
            switch totalScore {
            case 150...179:
                localGrade = Grade.three.rawValue
            case 180...219:
                localGrade = Grade.four.rawValue
            case 220...:
                localGrade = Grade.five.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        default:
            break
        }
        return localGrade
    }
    
    private func calculateMoreSixMonthGrade() -> String {
        var localGrade = ""
        
        switch numberOfExercise {
        case .three:
            switch totalScore {
            case 110...149:
                localGrade = Grade.three.rawValue
            case 150...169:
                localGrade = Grade.four.rawValue
            case 170...:
                localGrade = Grade.five.rawValue
            default:
                break
            }
        case .four:
            switch totalScore {
            case 170...199:
                localGrade = Grade.three.rawValue
            case 200...229:
                localGrade = Grade.four.rawValue
            case 230...:
                localGrade = Grade.five.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        default: break
        }
        return localGrade
    }
    
    private func calculateCadetFirstYearGrade() -> String {
        var localGrade = ""
        switch numberOfExercise {
        case .three:
            switch totalScore {
            case 120...159:
                localGrade = Grade.three.rawValue
            case 160...179:
                localGrade = Grade.four.rawValue
            case 180...199:
                localGrade = Grade.five.rawValue
            case 200...209:
                localGrade = Grade.secondLevel.rawValue
            case 210...219:
                localGrade = Grade.firstLevel.rawValue
            case 220...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .four:
            switch totalScore {
            case 170...219:
                localGrade = Grade.three.rawValue
            case 220...239:
                localGrade = Grade.four.rawValue
            case 240...259:
                localGrade = Grade.five.rawValue
            case 260...269:
                localGrade = Grade.secondLevel.rawValue
            case 270...279:
                localGrade = Grade.firstLevel.rawValue
            case 280...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .five:
            switch totalScore {
            case 220...259:
                localGrade = Grade.three.rawValue
            case 260...299:
                localGrade = Grade.four.rawValue
            case 300...309:
                localGrade = Grade.five.rawValue
            case 310...319:
                localGrade = Grade.secondLevel.rawValue
            case 320...329:
                localGrade = Grade.firstLevel.rawValue
            case 330...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        }
        return localGrade
    }
    
    private func calculateCadetSecondYearGrade() -> String {
        var localGrade = ""
        
        switch numberOfExercise {
        case .three:
            switch totalScore {
            case 130...169:
                localGrade = Grade.three.rawValue
            case 170...189:
                localGrade = Grade.four.rawValue
            case 190...209:
                localGrade = Grade.five.rawValue
            case 210...219:
                localGrade = Grade.secondLevel.rawValue
            case 220...229:
                localGrade = Grade.firstLevel.rawValue
            case 230...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .four:
            switch totalScore {
            case 190...229:
                localGrade = Grade.three.rawValue
            case 230...249:
                localGrade = Grade.four.rawValue
            case 250...269:
                localGrade = Grade.five.rawValue
            case 270...279:
                localGrade = Grade.secondLevel.rawValue
            case 280...289:
                localGrade = Grade.firstLevel.rawValue
            case 290...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .five:
            switch totalScore {
            case 230...269:
                localGrade = Grade.three.rawValue
            case 270...309:
                localGrade = Grade.four.rawValue
            case 310...319:
                localGrade = Grade.five.rawValue
            case 320...329:
                localGrade = Grade.secondLevel.rawValue
            case 330...339:
                localGrade = Grade.firstLevel.rawValue
            case 340...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        }
        return localGrade
    }
    
    private func calculateCadetThirdYearGrade() -> String {
        var localGrade = ""
        
        switch numberOfExercise {
        case .three:
            switch totalScore {
            case 150...189:
                localGrade = Grade.three.rawValue
            case 190...209:
                localGrade = Grade.four.rawValue
            case 210...229:
                localGrade = Grade.five.rawValue
            case 230...239:
                localGrade = Grade.secondLevel.rawValue
            case 240...249:
                localGrade = Grade.firstLevel.rawValue
            case 250...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .four:
            switch totalScore {
            case 200...249:
                localGrade = Grade.three.rawValue
            case 250...279:
                localGrade = Grade.four.rawValue
            case 280...299:
                localGrade = Grade.five.rawValue
            case 300...309:
                localGrade = Grade.secondLevel.rawValue
            case 310...319:
                localGrade = Grade.firstLevel.rawValue
            case 320...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .five:
            switch totalScore {
            case 250...309:
                localGrade = Grade.three.rawValue
            case 310...349:
                localGrade = Grade.four.rawValue
            case 350...369:
                localGrade = Grade.five.rawValue
            case 370...379:
                localGrade = Grade.secondLevel.rawValue
            case 380...389:
                localGrade = Grade.firstLevel.rawValue
            case 390...:
                localGrade = Grade.highLevel.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        }
        return localGrade
    }
    
    private func calculateFirstGroupGrade() -> String {
        var localGrade = ""
        
        switch category {
        case .firstCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 140...199:
                    localGrade = Grade.three.rawValue
                case 200...219:
                    localGrade = Grade.four.rawValue
                case 220...239:
                    localGrade = Grade.five.rawValue
                case 240...249:
                    localGrade = Grade.secondLevel.rawValue
                case 250...259:
                    localGrade = Grade.firstLevel.rawValue
                case 260...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 190...259:
                    localGrade = Grade.three.rawValue
                case 260...289:
                    localGrade = Grade.four.rawValue
                case 290...309:
                    localGrade = Grade.five.rawValue
                case 310...319:
                    localGrade = Grade.secondLevel.rawValue
                case 320...329:
                    localGrade = Grade.firstLevel.rawValue
                case 330...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 250...329:
                    localGrade = Grade.three.rawValue
                case 330...359:
                    localGrade = Grade.four.rawValue
                case 360...379:
                    localGrade = Grade.five.rawValue
                case 380...389:
                    localGrade = Grade.secondLevel.rawValue
                case 390...399:
                    localGrade = Grade.firstLevel.rawValue
                case 400...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        case .secondCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 140...189:
                    localGrade = Grade.three.rawValue
                case 190...209:
                    localGrade = Grade.four.rawValue
                case 210...229:
                    localGrade = Grade.five.rawValue
                case 230...239:
                    localGrade = Grade.secondLevel.rawValue
                case 240...249:
                    localGrade = Grade.firstLevel.rawValue
                case 250...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 180...249:
                    localGrade = Grade.three.rawValue
                case 250...279:
                    localGrade = Grade.four.rawValue
                case 280...299:
                    localGrade = Grade.five.rawValue
                case 300...309:
                    localGrade = Grade.secondLevel.rawValue
                case 310...319:
                    localGrade = Grade.firstLevel.rawValue
                case 320...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 230...309:
                    localGrade = Grade.three.rawValue
                case 310...349:
                    localGrade = Grade.four.rawValue
                case 350...369:
                    localGrade = Grade.five.rawValue
                case 370...379:
                    localGrade = Grade.secondLevel.rawValue
                case 380...389:
                    localGrade = Grade.firstLevel.rawValue
                case 390...:
                    localGrade = Grade.highLevel.rawValue
                default: localGrade = Grade.two.rawValue
                }
            }
        case .thirdCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 130...179:
                    localGrade = Grade.three.rawValue
                case 180...199:
                    localGrade = Grade.four.rawValue
                case 200...219:
                    localGrade = Grade.five.rawValue
                case 220...229:
                    localGrade = Grade.secondLevel.rawValue
                case 230...239:
                    localGrade = Grade.firstLevel.rawValue
                case 240...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 140...239:
                    localGrade = Grade.three.rawValue
                case 240...269:
                    localGrade = Grade.four.rawValue
                case 270...289:
                    localGrade = Grade.five.rawValue
                case 290...299:
                    localGrade = Grade.secondLevel.rawValue
                case 300...309:
                    localGrade = Grade.firstLevel.rawValue
                case 310...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 220...299:
                    localGrade = Grade.three.rawValue
                case 300...339:
                    localGrade = Grade.four.rawValue
                case 340...359:
                    localGrade = Grade.five.rawValue
                case 360...369:
                    localGrade = Grade.secondLevel.rawValue
                case 370...379:
                    localGrade = Grade.firstLevel.rawValue
                case 380...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        }
        return localGrade
    }
    
    
    private func calculateSecondGroupGrade() -> String {
        var localGrade = ""
        
        switch category {
        case .firstCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 140...179:
                    localGrade = Grade.three.rawValue
                case 180...199:
                    localGrade = Grade.four.rawValue
                case 200...219:
                    localGrade = Grade.five.rawValue
                case 220...229:
                    localGrade = Grade.secondLevel.rawValue
                case 230...239:
                    localGrade = Grade.firstLevel.rawValue
                case 240...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 180...229:
                    localGrade = Grade.three.rawValue
                case 230...259:
                    localGrade = Grade.four.rawValue
                case 260...279:
                    localGrade = Grade.five.rawValue
                case 280...289:
                    localGrade = Grade.secondLevel.rawValue
                case 290...299:
                    localGrade = Grade.firstLevel.rawValue
                case 300...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 210...289:
                    localGrade = Grade.three.rawValue
                case 290...319:
                    localGrade = Grade.four.rawValue
                case 320...339:
                    localGrade = Grade.five.rawValue
                case 340...349:
                    localGrade = Grade.secondLevel.rawValue
                case 350...359:
                    localGrade = Grade.firstLevel.rawValue
                case 360...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        case .secondCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 130...169:
                    localGrade = Grade.three.rawValue
                case 170...189:
                    localGrade = Grade.four.rawValue
                case 190...209:
                    localGrade = Grade.five.rawValue
                case 210...219:
                    localGrade = Grade.secondLevel.rawValue
                case 220...229:
                    localGrade = Grade.firstLevel.rawValue
                case 230...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 170...209:
                    localGrade = Grade.three.rawValue
                case 220...249:
                    localGrade = Grade.four.rawValue
                case 250...269:
                    localGrade = Grade.five.rawValue
                case 270...379:
                    localGrade = Grade.secondLevel.rawValue
                case 280...289:
                    localGrade = Grade.firstLevel.rawValue
                case 290...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 210...279:
                    localGrade = Grade.three.rawValue
                case 280...309:
                    localGrade = Grade.four.rawValue
                case 310...329:
                    localGrade = Grade.five.rawValue
                case 330...339:
                    localGrade = Grade.secondLevel.rawValue
                case 340...349:
                    localGrade = Grade.firstLevel.rawValue
                case 350...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        case .thirdCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 120...159:
                    localGrade = Grade.three.rawValue
                case 160...179:
                    localGrade = Grade.four.rawValue
                case 180...199:
                    localGrade = Grade.five.rawValue
                case 200...209:
                    localGrade = Grade.secondLevel.rawValue
                case 210...219:
                    localGrade = Grade.firstLevel.rawValue
                case 220...:
                    localGrade = Grade.highLevel.rawValue
                default: localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 160...209:
                    localGrade = Grade.three.rawValue
                case 210...239:
                    localGrade = Grade.four.rawValue
                case 240...259:
                    localGrade = Grade.five.rawValue
                case 260...269:
                    localGrade = Grade.secondLevel.rawValue
                case 270...279:
                    localGrade = Grade.firstLevel.rawValue
                case 280...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 200...269:
                    localGrade = Grade.three.rawValue
                case 270...299:
                    localGrade = Grade.four.rawValue
                case 300...319:
                    localGrade = Grade.five.rawValue
                case 320...329:
                    localGrade = Grade.secondLevel.rawValue
                case 330...339:
                    localGrade = Grade.firstLevel.rawValue
                case 340...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        }
        return localGrade
    }
    
    private func calculateThirdGroupGrade() -> String {
        var localGrade = ""
        
        switch category {
        case .firstCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 120...159:
                    localGrade = Grade.three.rawValue
                case 160...179:
                    localGrade = Grade.four.rawValue
                case 180...199:
                    localGrade = Grade.five.rawValue
                case 200...209:
                    localGrade = Grade.secondLevel.rawValue
                case 210...219:
                    localGrade = Grade.firstLevel.rawValue
                case 220...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 160...209:
                    localGrade = Grade.three.rawValue
                case 210...229:
                    localGrade = Grade.four.rawValue
                case 240...249:
                    localGrade = Grade.five.rawValue
                case 250...259:
                    localGrade = Grade.secondLevel.rawValue
                case 260...269:
                    localGrade = Grade.firstLevel.rawValue
                case 270...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 190...249:
                    localGrade = Grade.three.rawValue
                case 250...289:
                    localGrade = Grade.four.rawValue
                case 290...299:
                    localGrade = Grade.five.rawValue
                case 300...309:
                    localGrade = Grade.secondLevel.rawValue
                case 310...319:
                    localGrade = Grade.firstLevel.rawValue
                case 320...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        case .secondCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 110...149:
                    localGrade = Grade.three.rawValue
                case 150...169:
                    localGrade = Grade.four.rawValue
                case 170...179:
                    localGrade = Grade.five.rawValue
                case 180...189:
                    localGrade = Grade.secondLevel.rawValue
                case 190...199:
                    localGrade = Grade.firstLevel.rawValue
                case 200...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 150...199:
                    localGrade = Grade.three.rawValue
                case 200...229:
                    localGrade = Grade.four.rawValue
                case 230...239:
                    localGrade = Grade.five.rawValue
                case 240...249:
                    localGrade = Grade.secondLevel.rawValue
                case 250...259:
                    localGrade = Grade.firstLevel.rawValue
                case 260...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 170...239:
                    localGrade = Grade.three.rawValue
                case 240...269:
                    localGrade = Grade.four.rawValue
                case 270...279:
                    localGrade = Grade.five.rawValue
                case 280...289:
                    localGrade = Grade.secondLevel.rawValue
                case 290...299:
                    localGrade = Grade.firstLevel.rawValue
                case 300...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        case .thirdCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 100...139:
                    localGrade = Grade.three.rawValue
                case 140...159:
                    localGrade = Grade.four.rawValue
                case 160...169:
                    localGrade = Grade.five.rawValue
                case 170...179:
                    localGrade = Grade.secondLevel.rawValue
                case 180...189:
                    localGrade = Grade.firstLevel.rawValue
                case 190...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 140...189:
                    localGrade = Grade.three.rawValue
                case 190...219:
                    localGrade = Grade.four.rawValue
                case 220...229:
                    localGrade = Grade.five.rawValue
                case 230...239:
                    localGrade = Grade.secondLevel.rawValue
                case 240...249:
                    localGrade = Grade.firstLevel.rawValue
                case 250...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 150...219:
                    localGrade = Grade.three.rawValue
                case 220...249:
                    localGrade = Grade.four.rawValue
                case 250...359:
                    localGrade = Grade.five.rawValue
                case 260...269:
                    localGrade = Grade.secondLevel.rawValue
                case 270...279:
                    localGrade = Grade.firstLevel.rawValue
                case 280...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        }
        return localGrade
    }
    
    private func calculateFourthGroupGrade() -> String {
        var localGrade = ""
        
        switch category {
        case .firstCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 100...149:
                    localGrade = Grade.three.rawValue
                case 150...169:
                    localGrade = Grade.four.rawValue
                case 170...189:
                    localGrade = Grade.five.rawValue
                case 190...199:
                    localGrade = Grade.secondLevel.rawValue
                case 200...209:
                    localGrade = Grade.firstLevel.rawValue
                case 210...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 140...199:
                    localGrade = Grade.three.rawValue
                case 200...229:
                    localGrade = Grade.four.rawValue
                case 230...239:
                    localGrade = Grade.five.rawValue
                case 240...249:
                    localGrade = Grade.secondLevel.rawValue
                case 250...259:
                    localGrade = Grade.firstLevel.rawValue
                case 260...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 170...229:
                    localGrade = Grade.three.rawValue
                case 230...269:
                    localGrade = Grade.four.rawValue
                case 270...279:
                    localGrade = Grade.five.rawValue
                case 280...289:
                    localGrade = Grade.secondLevel.rawValue
                case 290...299:
                    localGrade = Grade.firstLevel.rawValue
                case 300...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        case .secondCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 90...139:
                    localGrade = Grade.three.rawValue
                case 140...159:
                    localGrade = Grade.four.rawValue
                case 160...169:
                    localGrade = Grade.five.rawValue
                case 170...179:
                    localGrade = Grade.secondLevel.rawValue
                case 180...189:
                    localGrade = Grade.firstLevel.rawValue
                case 190...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 120...179:
                    localGrade = Grade.three.rawValue
                case 180...209:
                    localGrade = Grade.four.rawValue
                case 210...229:
                    localGrade = Grade.five.rawValue
                case 230...239:
                    localGrade = Grade.secondLevel.rawValue
                case 240...249:
                    localGrade = Grade.firstLevel.rawValue
                case 250...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 150...219:
                    localGrade = Grade.three.rawValue
                case 220...249:
                    localGrade = Grade.four.rawValue
                case 250...259:
                    localGrade = Grade.five.rawValue
                case 260...269:
                    localGrade = Grade.secondLevel.rawValue
                case 270...279:
                    localGrade = Grade.firstLevel.rawValue
                case 280...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        case .thirdCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 80...129:
                    localGrade = Grade.three.rawValue
                case 130...149:
                    localGrade = Grade.four.rawValue
                case 150...159:
                    localGrade = Grade.five.rawValue
                case 160...169:
                    localGrade = Grade.secondLevel.rawValue
                case 170...179:
                    localGrade = Grade.firstLevel.rawValue
                case 180...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 110...169:
                    localGrade = Grade.three.rawValue
                case 170...199:
                    localGrade = Grade.four.rawValue
                case 200...219:
                    localGrade = Grade.five.rawValue
                case 220...229:
                    localGrade = Grade.secondLevel.rawValue
                case 230...239:
                    localGrade = Grade.firstLevel.rawValue
                case 240...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .five:
                switch totalScore {
                case 130...199:
                    localGrade = Grade.three.rawValue
                case 200...229:
                    localGrade = Grade.four.rawValue
                case 230...259:
                    localGrade = Grade.five.rawValue
                case 260...269:
                    localGrade = Grade.secondLevel.rawValue
                case 270...279:
                    localGrade = Grade.firstLevel.rawValue
                case 280...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            }
        }
        return localGrade
    }
    
    private func calculateFifthGroupGrade() -> String {
        var localGrade = ""
        
        switch category {
        case .firstCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 90...119:
                    localGrade = Grade.three.rawValue
                case 120...139:
                    localGrade = Grade.four.rawValue
                case 140...159:
                    localGrade = Grade.five.rawValue
                case 160...169:
                    localGrade = Grade.secondLevel.rawValue
                case 170...179:
                    localGrade = Grade.firstLevel.rawValue
                case 180...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 120...159:
                    localGrade = Grade.three.rawValue
                case 160...189:
                    localGrade = Grade.four.rawValue
                case 190...209:
                    localGrade = Grade.five.rawValue
                case 210...219:
                    localGrade = Grade.secondLevel.rawValue
                case 220...229:
                    localGrade = Grade.firstLevel.rawValue
                case 230...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        case .secondCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 80...99:
                    localGrade = Grade.three.rawValue
                case 100...129:
                    localGrade = Grade.four.rawValue
                case 130...149:
                    localGrade = Grade.five.rawValue
                case 150...159:
                    localGrade = Grade.secondLevel.rawValue
                case 160...169:
                    localGrade = Grade.firstLevel.rawValue
                case 170...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 110...139:
                    localGrade = Grade.three.rawValue
                case 140...179:
                    localGrade = Grade.four.rawValue
                case 180...199:
                    localGrade = Grade.five.rawValue
                case 200...209:
                    localGrade = Grade.secondLevel.rawValue
                case 210...229:
                    localGrade = Grade.firstLevel.rawValue
                case 230...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        case .thirdCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 70...89:
                    localGrade = Grade.three.rawValue
                case 90...119:
                    localGrade = Grade.four.rawValue
                case 120...139:
                    localGrade = Grade.five.rawValue
                case 140...149:
                    localGrade = Grade.secondLevel.rawValue
                case 150...159:
                    localGrade = Grade.firstLevel.rawValue
                case 160...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            case .four:
                switch totalScore {
                case 100...119:
                    localGrade = Grade.three.rawValue
                case 120...159:
                    localGrade = Grade.four.rawValue
                case 160...179:
                    localGrade = Grade.five.rawValue
                case 180...189:
                    localGrade = Grade.secondLevel.rawValue
                case 190...199:
                    localGrade = Grade.firstLevel.rawValue
                case 200...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        }
        return localGrade
    }
    
    private func calculateSixthGroupGrade() -> String {
        var localGrade = ""
        
        switch category {
        case .firstCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 80...89:
                    localGrade = Grade.three.rawValue
                case 90...119:
                    localGrade = Grade.four.rawValue
                case 120...139:
                    localGrade = Grade.five.rawValue
                case 140...149:
                    localGrade = Grade.secondLevel.rawValue
                case 150...159:
                    localGrade = Grade.firstLevel.rawValue
                case 160...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        case .secondCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 60...69:
                    localGrade = Grade.three.rawValue
                case 70...99:
                    localGrade = Grade.four.rawValue
                case 100...119:
                    localGrade = Grade.five.rawValue
                case 120...129:
                    localGrade = Grade.secondLevel.rawValue
                case 130...139:
                    localGrade = Grade.firstLevel.rawValue
                case 140...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        case .thirdCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 50...59:
                    localGrade = Grade.three.rawValue
                case 60...89:
                    localGrade = Grade.four.rawValue
                case 90...109:
                    localGrade = Grade.five.rawValue
                case 110...119:
                    localGrade = Grade.secondLevel.rawValue
                case 120...129:
                    localGrade = Grade.firstLevel.rawValue
                case 130...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        }
        return localGrade
    }
    
    private func calculateSeventhGroupGrade() -> String {
        var localGrade = ""
        
        switch category {
        case .firstCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 70...69:
                    localGrade = Grade.three.rawValue
                case 80...109:
                    localGrade = Grade.four.rawValue
                case 110...129:
                    localGrade = Grade.five.rawValue
                case 130...139:
                    localGrade = Grade.secondLevel.rawValue
                case 140...149:
                    localGrade = Grade.firstLevel.rawValue
                case 150...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        case .secondCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 50...69:
                    localGrade = Grade.three.rawValue
                case 60...89:
                    localGrade = Grade.four.rawValue
                case 90...109:
                    localGrade = Grade.five.rawValue
                case 110...119:
                    localGrade = Grade.secondLevel.rawValue
                case 120...129:
                    localGrade = Grade.firstLevel.rawValue
                case 130...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        case .thirdCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 40...49:
                    localGrade = Grade.three.rawValue
                case 50...79:
                    localGrade = Grade.four.rawValue
                case 80...99:
                    localGrade = Grade.five.rawValue
                case 100...109:
                    localGrade = Grade.secondLevel.rawValue
                case 110...119:
                    localGrade = Grade.firstLevel.rawValue
                case 120...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        }
        return localGrade
    }
    
    private func calculateEighthGroupGrade() -> String {
        var localGrade = ""
        
        switch category {
        case .firstCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 60...79:
                    localGrade = Grade.three.rawValue
                case 80...99:
                    localGrade = Grade.four.rawValue
                case 100...119:
                    localGrade = Grade.five.rawValue
                case 120...129:
                    localGrade = Grade.secondLevel.rawValue
                case 130...139:
                    localGrade = Grade.firstLevel.rawValue
                case 140...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        case .secondCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 40...59:
                    localGrade = Grade.three.rawValue
                case 60...79:
                    localGrade = Grade.four.rawValue
                case 80...99:
                    localGrade = Grade.five.rawValue
                case 100...109:
                    localGrade = Grade.secondLevel.rawValue
                case 110...119:
                    localGrade = Grade.firstLevel.rawValue
                case 120...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        case .thirdCategory:
            switch numberOfExercise {
            case .three:
                switch totalScore {
                case 30...49:
                    localGrade = Grade.three.rawValue
                case 50...69:
                    localGrade = Grade.four.rawValue
                case 70...89:
                    localGrade = Grade.five.rawValue
                case 90...99:
                    localGrade = Grade.secondLevel.rawValue
                case 100...109:
                    localGrade = Grade.firstLevel.rawValue
                case 110...:
                    localGrade = Grade.highLevel.rawValue
                default:
                    localGrade = Grade.two.rawValue
                }
            default:
                break
            }
        }
        return localGrade
    }
    
    
    //MARK: - Private methods for woman
    
    private func calculateWomanCandidateGrade() -> String {
        var localGrade = ""
        
        switch numberOfExercise {
        case .three:
            switch totalScore {
            case 120...149:
                localGrade = Grade.three.rawValue
            case 150...169:
                localGrade = Grade.four.rawValue
            case 170...:
                localGrade = Grade.five.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        case .four:
            switch totalScore {
            case 170...209:
                localGrade = Grade.three.rawValue
            case 210...229:
                localGrade = Grade.four.rawValue
            case 230...:
                localGrade = Grade.five.rawValue
            default:
                localGrade = Grade.two.rawValue
            }
        default:
            break
        }
        return localGrade
    }
    
    private func calculateWomanFirstGroupGrade() -> String {
        
        switch totalScore {
        case 110...139:
            return Grade.three.rawValue
        case 140...159:
            return Grade.four.rawValue
        case 160...179:
            return Grade.five.rawValue
        case 180...189:
            return Grade.secondLevel.rawValue
        case 190...199:
            return Grade.firstLevel.rawValue
        case 200...:
            return Grade.highLevel.rawValue
        default:
            return Grade.two.rawValue
        }
    }
    
    private func calculateWomanSecondGroupGrade() -> String {
        
        switch totalScore {
        case 90...119:
            return Grade.three.rawValue
        case 120...139:
            return Grade.four.rawValue
        case 140...159:
            return Grade.five.rawValue
        case 160...169:
            return Grade.secondLevel.rawValue
        case 170...179:
            return Grade.firstLevel.rawValue
        case 180...:
            return Grade.highLevel.rawValue
        default:
            return Grade.two.rawValue
        }
    }
    
    private func calculateWomanThirdGroupGrade() -> String {
        
        switch totalScore {
        case 80...109:
            return Grade.three.rawValue
        case 110...129:
            return Grade.four.rawValue
        case 130...149:
            return Grade.five.rawValue
        case 150...159:
            return Grade.secondLevel.rawValue
        case 160...169:
            return Grade.firstLevel.rawValue
        case 170...:
            return Grade.highLevel.rawValue
        default:
            return Grade.two.rawValue
        }
    }
    
    private func calculateWomanFourthGroupGrade() -> String {
        
        switch totalScore {
        case 70...99:
            return Grade.three.rawValue
        case 100...119:
            return Grade.four.rawValue
        case 120...139:
            return Grade.five.rawValue
        case 140...149:
            return Grade.secondLevel.rawValue
        case 150...159:
            return Grade.firstLevel.rawValue
        case 160...:
            return Grade.highLevel.rawValue
        default:
            return Grade.two.rawValue
        }
    }
    
    private func calculateWomanFifthGroupGrade() -> String {
        
        switch totalScore {
        case 60...89:
            return Grade.three.rawValue
        case 90...109:
            return Grade.four.rawValue
        case 110...129:
            return Grade.five.rawValue
        case 130...139:
            return Grade.secondLevel.rawValue
        case 140...149:
            return Grade.firstLevel.rawValue
        case 150...:
            return Grade.highLevel.rawValue
        default:
            return Grade.two.rawValue
        }
    }
    
    private func calculateWomanSixthGroupGrade() -> String {
        
        switch totalScore {
        case 50...79:
            return Grade.three.rawValue
        case 80...99:
            return Grade.four.rawValue
        case 100...119:
            return Grade.five.rawValue
        case 120...129:
            return Grade.secondLevel.rawValue
        case 130...139:
            return Grade.firstLevel.rawValue
        case 140...:
            return Grade.highLevel.rawValue
        default:
            return Grade.two.rawValue
        }
    }
    

    //MARK: - Calculating money
    
    let tariff: [String: Double] = [
        "1" : 11588, "2" : 12745, "3" : 13905, "4" : 15064, "5" : 17381, "6" : 18539, "7" : 19698, "8" : 20277,
        "9" : 20856, "10" : 23173, "11" : 23753, "12" : 24333, "13" : 24911, "14" : 25490, "15" : 26071, "16" : 26649,
        "17" : 27228, "18" : 27809, "19" : 28387, "20" : 28966, "21" : 29546, "22" : 30125, "23" : 30705, "24" : 31284,
        "25" : 31862, "26" : 32443, "27" : 33022, "28" : 33600, "29" : 34181, "30" : 34760, "31" : 35338, "32" : 35918,
        "33" : 36498, "34" : 37077, "35" : 37656, "36" : 38235, "37" : 38815, "38" : 39394, "39" : 39973, "40" : 40552,
        "41" : 41132, "42" : 41711,  "43" : 42290, "44" : 42870, "45" : 43449, "46" : 44028, "47" : 46345, "48" : 48663,
        "49" : 50979, "50" : 52139
    ]
    
    func getAmountOfMoney() -> String {
        guard let tariff = tariff[String(settings.tariff)] else { return "tariff not found" }
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

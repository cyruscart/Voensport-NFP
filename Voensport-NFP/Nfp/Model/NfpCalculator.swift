//
//  NfpCalculator.swift
//  Voensport-NFP
//
//  Created by Кирилл on 26.01.2022.
//

import Foundation

final class NfpCalculator {
    var settings = Settings()
    
    var minimumScore: Int {
        settings.sex == .male ? getMinimumScoreForMan() : getMinimumScoreForWoman()
    }

    func getGrade(totalScore: Int) -> String {
        return settings.sex == .male
        ? calculateManGrade(totalScore: totalScore)
        : calculateWomanGrade(totalScore: totalScore)
    }
    
    private func calculateManGrade(totalScore: Int) -> String {
        switch settings.maleAgeCategory {
        case .candidate: return
            calculateCandidateGrade(totalScore: totalScore)
        case .solderLessSixMonths:
            return calculateLessSixMonthGrade(totalScore: totalScore)
        case .solderMoreSixMonths:
            return calculateMoreSixMonthGrade(totalScore: totalScore)
        case .cadetFirstYear:
            return calculateCadetFirstYearGrade(totalScore: totalScore)
        case .cadetSecondYear:
            return calculateCadetSecondYearGrade(totalScore: totalScore)
        case .cadetThirdYearAndOlder:
            return calculateCadetThirdYearGrade(totalScore: totalScore)
        case .firstAgeGroup:
            return calculateFirstGroupGrade(totalScore: totalScore)
        case .secondAgeGroup:
            return calculateSecondGroupGrade(totalScore: totalScore)
        case .thirdAgeGroup:
            return calculateThirdGroupGrade(totalScore: totalScore)
        case .fourthAgeGroup:
            return calculateFourthGroupGrade(totalScore: totalScore)
        case .fifthAgeGroup:
            return calculateFifthGroupGrade(totalScore: totalScore)
        case .sixthAgeGroup:
            return calculateSixthGroupGrade(totalScore: totalScore)
        case .seventhAgeGroup:
            return calculateSeventhGroupGrade(totalScore: totalScore)
        case .eighthAgeGroup:
            return calculateEighthGroupGrade(totalScore: totalScore)
        }
    }

    private func calculateWomanGrade(totalScore: Int) -> String {
        switch settings.femaleAgeCategory {
        case .candidate:
            return calculateWomanCandidateGrade(totalScore: totalScore)
        case .firstAgeGroup:
            return calculateWomanFirstGroupGrade(totalScore: totalScore)
        case .secondAgeGroup:
            return calculateWomanSecondGroupGrade(totalScore: totalScore)
        case .thirdAgeGroup:
            return calculateWomanThirdGroupGrade(totalScore: totalScore)
        case .fourthAgeGroup:
            return calculateWomanFourthGroupGrade(totalScore: totalScore)
        case .fifthAgeGroup:
            return calculateWomanFifthGroupGrade(totalScore: totalScore)
        case .sixthAgeGroup:
            return calculateWomanSixthGroupGrade(totalScore: totalScore)
        }
    }

    //MARK: - Man calculation methods

    private func getMinimumScoreForMan() -> Int {
        switch settings.maleAgeCategory {
        case .candidate: return 26
        case .solderLessSixMonths: return 26
        case .solderMoreSixMonths: return 28
        case .cadetFirstYear: return 28
        case .cadetSecondYear: return 30
        case .cadetThirdYearAndOlder: return 32
        case .firstAgeGroup: return 30
        case .secondAgeGroup: return 28
        case .thirdAgeGroup: return 24
        case .fourthAgeGroup: return 22
        case .fifthAgeGroup: return 20
        case .sixthAgeGroup: return 16
        case .seventhAgeGroup: return 12
        case .eighthAgeGroup: return 6
        }
    }

    private func calculateCandidateGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.numberOfExercise {
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

    private func calculateLessSixMonthGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.numberOfExercise {
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

    private func calculateMoreSixMonthGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.numberOfExercise {
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

    private func calculateCadetFirstYearGrade(totalScore: Int) -> String {
        var localGrade = ""
        switch settings.numberOfExercise {
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

    private func calculateCadetSecondYearGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.numberOfExercise {
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

    private func calculateCadetThirdYearGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.numberOfExercise {
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

    private func calculateFirstGroupGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.category {
        case .firstCategory:
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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


    private func calculateSecondGroupGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.category {
        case .firstCategory:
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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

    private func calculateThirdGroupGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.category {
        case .firstCategory:
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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

    private func calculateFourthGroupGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.category {
        case .firstCategory:
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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

    private func calculateFifthGroupGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.category {
        case .firstCategory:
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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

    private func calculateSixthGroupGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.category {
        case .firstCategory:
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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

    private func calculateSeventhGroupGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.category {
        case .firstCategory:
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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

    private func calculateEighthGroupGrade(totalScore: Int) -> String {
        var localGrade = ""

        switch settings.category {
        case .firstCategory:
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
            switch settings.numberOfExercise {
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
    
    //MARK: - Woman calculation methods
    
    private func getMinimumScoreForWoman() -> Int {
        switch settings.femaleAgeCategory {
        case .candidate: return 26
        case .firstAgeGroup: return 28
        case .secondAgeGroup: return 26
        case .thirdAgeGroup: return 24
        case .fourthAgeGroup: return 22
        case .fifthAgeGroup: return 20
        case .sixthAgeGroup: return 18
        }
    }
    
    private func calculateWomanCandidateGrade(totalScore: Int) -> String {
        var localGrade = ""
        
        switch settings.numberOfExercise {
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
    
    private func calculateWomanFirstGroupGrade(totalScore: Int) -> String {
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
    
    private func calculateWomanSecondGroupGrade(totalScore: Int) -> String {
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
    
    private func calculateWomanThirdGroupGrade(totalScore: Int) -> String {
        
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
    
    private func calculateWomanFourthGroupGrade(totalScore: Int) -> String {
        
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
    
    private func calculateWomanFifthGroupGrade(totalScore: Int) -> String {
        
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
    
    private func calculateWomanSixthGroupGrade(totalScore: Int) -> String {
        
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
}
        

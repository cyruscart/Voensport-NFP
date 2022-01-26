//
//  Settings.swift
//  VoenSport
//
//  Created by Кирилл on 02.10.2021.
//

import Foundation

final class Settings: Codable {
    
    var sex: Sex = .male
    var maleAgeCategory: MaleAgeCategory = .firstAgeGroup
    var femaleAgeCategory: FemaleAgeCategory = .firstAgeGroup
    var category: Category = .firstCategory
    var numberOfExercise: NumberOfExercise = .three
    var hapticOn = true
    var tariff = 0
    var sportGrade: SportGrade = .withoutGrade
    var shouldShowOnboarding = true
    
    var sectionKind: [Int] {
        Array(0..<getIntegerNumberOfExercises())
    }
    
    var isManOlderThirtyFive: Bool {
        maleAgeCategory == .fourthAgeGroup ||
        maleAgeCategory == .fifthAgeGroup ||
        maleAgeCategory == .sixthAgeGroup ||
        maleAgeCategory == .seventhAgeGroup ||
        maleAgeCategory == .eighthAgeGroup
    }
    
    var isWomanOlderThirty: Bool {
        femaleAgeCategory == .thirdAgeGroup ||
        femaleAgeCategory == .fourthAgeGroup ||
        femaleAgeCategory == .fifthAgeGroup ||
        femaleAgeCategory == .sixthAgeGroup
    }
    
    private var shouldShowCategoryInsteadExercise: Bool {
        sex == .male && (
            maleAgeCategory == .sixthAgeGroup ||
            maleAgeCategory == .seventhAgeGroup ||
            maleAgeCategory == .eighthAgeGroup
        )
    }
    
    private var shouldShowCategory: Bool {
        maleAgeCategory == .firstAgeGroup ||
        maleAgeCategory == .secondAgeGroup ||
        maleAgeCategory == .thirdAgeGroup ||
        maleAgeCategory == .fourthAgeGroup ||
        maleAgeCategory == .fifthAgeGroup ||
        maleAgeCategory == .sixthAgeGroup ||
        maleAgeCategory == .seventhAgeGroup ||
        maleAgeCategory == .eighthAgeGroup
    }
    
    private var shouldShowNumberOfExercise: Bool {
        maleAgeCategory == .candidate ||
        maleAgeCategory == .solderLessSixMonths ||
        maleAgeCategory == .solderMoreSixMonths ||
        maleAgeCategory == .cadetFirstYear ||
        maleAgeCategory == .cadetSecondYear ||
        maleAgeCategory == .cadetThirdYearAndOlder ||
        maleAgeCategory == .firstAgeGroup ||
        maleAgeCategory == .secondAgeGroup ||
        maleAgeCategory == .thirdAgeGroup ||
        maleAgeCategory == .fourthAgeGroup ||
        maleAgeCategory == .fifthAgeGroup
    }
    
    private var shouldShowOnlySexAndAge: Bool {
        sex == .female && femaleAgeCategory != .candidate
    }
    
    private var shouldShowFourSections: Bool {
        (sex == .male && shouldShowCategory && shouldShowNumberOfExercise)
    }
    

    //MARK: - Enumerations
    
    enum SettingTitle: String, CaseIterable {
        case sex = "Пол"
        case ageCategory = "Возрастная категория"
        case numberOfExercise = "Количество упражнений"
        case category = "Категория"
        case tariff = "Тарифный разряд"
        case haptic = "Тактильный отклик"
    }
    
    enum SettingTitleForOld: String, CaseIterable {
        case sex = "Пол"
        case ageCategory = "Возрастная категория"
        case category = "Категория"
        case numberOfExercise = "Количество упражнений"
        case tariff = "Тарифный разряд"
        case haptic = "Тактильный отклик"
    }
    
    // MARK: -  Methods
    
    func getNumberOfExerciseList() -> [NumberOfExercise] {
        if (sex == .female && femaleAgeCategory == .candidate) ||
            maleAgeCategory == .fifthAgeGroup ||
            maleAgeCategory == .candidate ||
            maleAgeCategory == .solderLessSixMonths ||
            maleAgeCategory == .solderMoreSixMonths {
            return [NumberOfExercise.three, NumberOfExercise.four]
        } else {
            return NumberOfExercise.allCases
        }
    }
    
    func getIntegerNumberOfExercises() -> Int {
        switch numberOfExercise {
        case .three: return 3
        case .four: return 4
        case .five: return 5
        }
    }
    
    func settingGroupDidSelect(_ indexPath: IndexPath, _ selectedSetting: inout String) -> Bool {
        var shouldShowDetailSettings = true
        
        switch indexPath.section {
        case getNumberOfSectionForSettings() - 1:
            shouldShowDetailSettings = false
        case getNumberOfSectionForSettings() - 2:
            selectedSetting = "tariff"
        case 0:
            selectedSetting = "sex"
        case 1:
            selectedSetting = sex == .male
            ? "maleAge"
            : "femaleAge"
        case 2:
            selectedSetting = shouldShowCategoryInsteadExercise
            ? "category"
            : "numberOfExercise"
        default:
            selectedSetting = "category"
        }
        return shouldShowDetailSettings
    }
    
    func settingDidSelect(didSelectRowAt indexPath: IndexPath, currentSetting: String) {
        
        switch currentSetting {
        case "sex":
            sex = Sex.allCases[indexPath.row]
        case "maleAge":
            maleAgeCategory = MaleAgeCategory.allCases[indexPath.row]
            changeNumberOfExercise()
        case "femaleAge":
            femaleAgeCategory = FemaleAgeCategory.allCases[indexPath.row]
        case "numberOfExercise":
            numberOfExercise = NumberOfExercise.allCases[indexPath.row]
        default:
            category = Category.allCases[indexPath.row]
        }
        
    }
    
    func getNumberOfSectionForSettings() -> Int {
        if shouldShowOnlySexAndAge {
            return 4
        } else if shouldShowFourSections {
            return 6
        } else {
            return 5
        }
    }
    
    func getNumberOfRowsForDetailSettings(_ currentSetting: String) -> Int {
        switch currentSetting {
        case "sex":
            return Sex.allCases.count
        case "maleAge":
            return MaleAgeCategory.allCases.count
        case "femaleAge":
            return FemaleAgeCategory.allCases.count
        case "numberOfExercise":
            return getNumberOfExerciseList().count
        case "tariff":
            return 3
        default:
            return Category.allCases.count
        }
    }
    
    func getTitleForSectionForSettingsList(section: Int) -> String? {
        if section == getNumberOfSectionForSettings() - 1 {
            return "Тактильный отклик"
        } else if section == getNumberOfSectionForSettings() - 2 {
            return "Тарифный разряд"
        } else {
            return shouldShowCategoryInsteadExercise
            ? SettingTitleForOld.allCases[section].rawValue
            : SettingTitle.allCases[section].rawValue
        }
    }
    
    func getTextForCell(section: Int) -> String {
        switch section {
        case getNumberOfSectionForSettings() - 2:
            return tariff == 0
            ? "Выберите тарифный разряд"
            : "\(tariff) тарифный разряд"
        case 0:
            return sex.rawValue
        case 1:
            return sex == .male
            ? maleAgeCategory.rawValue
            : femaleAgeCategory.rawValue
        case 2:
            return shouldShowCategoryInsteadExercise
            ? category.rawValue
            : numberOfExercise.rawValue
        case 3:
            return category.rawValue
        default:
            return "Error"
        }
    }
    
   func getNavigationTitle(for currentSettings: String) -> String {
        switch currentSettings {
        case "sex":
            return "Пол"
        case "maleAge":
            return "Возрастная категория"
        case "femaleAge":
            return "Возрастная категория"
        case "numberOfExercise":
            return "Количество упражнений"
        case "tariff":
            return "Тарифный разряд"
        default:
            return "Категория"
        }
    }
    
    func setNumberOfExercise() {
        if sex == .female || shouldShowCategoryInsteadExercise {
            numberOfExercise = .three
        }
    }
    
    // MARK: -  Private methods
    
    private func changeNumberOfExercise() {
        if maleAgeCategory == .candidate ||
            maleAgeCategory == .solderLessSixMonths ||
            maleAgeCategory == .fifthAgeGroup {
            numberOfExercise = .three
        }
    }
    
}

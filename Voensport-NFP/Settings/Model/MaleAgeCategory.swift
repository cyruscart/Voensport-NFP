//
//  MaleAgeCategory.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import Foundation

enum MaleAgeCategory: String, CaseIterable, Codable {
    case candidate = "Кандидаты в военно-учебные заведения из числа граждаской молодежи и военнослужащих"
    case solderLessSixMonths = "Военнослужащие по призыву до 6 месяцев"
    case solderMoreSixMonths = "Военнослужащие по призыву после 6 месяцев"
    case cadetFirstYear = "Курсанты 1-го курса"
    case cadetSecondYear = "Курсанты 2-го курса"
    case cadetThirdYearAndOlder = "Курсанты 3-го курса и старше"
    case firstAgeGroup = "Военнослужащие по контракту 1 возрастной группы (до 25 лет)"
    case secondAgeGroup = "Военнослужащие по контракту 2 возрастной группы (25 - 29)"
    case thirdAgeGroup = "Военнослужащие по контракту 3 возрастной группы (30 - 34)"
    case fourthAgeGroup = "Военнослужащие по контракту 4 возрастной группы (35 - 39)"
    case fifthAgeGroup = "Военнослужащие по контракту 5 возрастной группы (40 - 44)"
    case sixthAgeGroup = "Военнослужащие по контракту 6 возрастной группы (45 - 49)"
    case seventhAgeGroup = "Военнослужащие по контракту 7 возрастной группы (50 - 54)"
    case eighthAgeGroup = "Военнослужащие по контракту 8 возрастной группы (55 лет и старше)"
}

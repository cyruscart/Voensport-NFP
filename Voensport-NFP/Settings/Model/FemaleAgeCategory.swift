//
//  FemaleAgeCategory.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import Foundation

enum FemaleAgeCategory: String, CaseIterable, Codable {
    case candidate = "Кандидаты в военно-учебные заведения из числа граждаской молодежи и военнослужащих женского пола"
    case firstAgeGroup = "Военнослужащие женского пола 1 возрастной группы (до 25 лет)"
    case secondAgeGroup = "Военнослужащие женского пола 2 возрастной группы (25 - 29)"
    case thirdAgeGroup = "Военнослужащие женского пола 3 возрастной группы (30 - 34)"
    case fourthAgeGroup = "Военнослужащие женского пола 4 возрастной группы (35 - 39)"
    case fifthAgeGroup = "Военнослужащие женского пола 5 возрастной группы (40 - 44)"
    case sixthAgeGroup = "Военнослужащие женского пола 6 возрастной группы (45 лет и старше)"
}

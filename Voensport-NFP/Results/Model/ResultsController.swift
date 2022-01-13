//
//  ResultsController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 22.12.2021.
//

import Foundation

enum ResultType {
    case nfp
    case sport
}

struct ResultsController: Codable {
    var nfpResults: [NfpResult] = []
    var sportResults: [SportResult] = []
    
    var shouldReloadData: Bool {
        nfpResults.isEmpty || sportResults.isEmpty
    }
    
    func getTitleForHeaderInSection(for section: Int) -> String {
        switch section {
        case 0:
            return nfpResults.isEmpty ? "Нет результатов сдачи ФП" : "Результаты сдачи ФП"
        default:
            return sportResults.isEmpty ? "Нет спортивных результатов" : "Спортивные результаты"
        }
    }
    
}

//
//  TriathlonType.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import Foundation

enum sportTypes: String, CaseIterable, Codable {
    case summerTriathlon = "Летнее офицерское троеборье"
    case winterTriathlon = "Зимнее офицерское троеборье"
}

enum TriathlonType: String, Codable {
    case summer = "Летнее офицерское троеборье"
    case winter = "Зимнее офицерское троеборье"
}

enum TriathlonAgeCategory: String, CaseIterable, Codable {
    case lessThirty = "До 30 лет"
    case lessForty = "30-40 лет"
    case moreForty = "Свыше 40 лет"
}

//
//  Tariff.swift
//  Voensport-NFP
//
//  Created by Кирилл on 18.12.2021.
//

import Foundation

struct Tariff: Codable {
    
   static let tariff: [String: Double] = [
        "1" : 11588, "2" : 12745, "3" : 13905, "4" : 15064, "5" : 17381, "6" : 18539, "7" : 19698, "8" : 20277,
        "9" : 20856, "10" : 23173, "11" : 23753, "12" : 24333, "13" : 24911, "14" : 25490, "15" : 26071, "16" : 26649,
        "17" : 27228, "18" : 27809, "19" : 28387, "20" : 28966, "21" : 29546, "22" : 30125, "23" : 30705, "24" : 31284,
        "25" : 31862, "26" : 32443, "27" : 33022, "28" : 33600, "29" : 34181, "30" : 34760, "31" : 35338, "32" : 35918,
        "33" : 36498, "34" : 37077, "35" : 37656, "36" : 38235, "37" : 38815, "38" : 39394, "39" : 39973, "40" : 40552,
        "41" : 41132, "42" : 41711,  "43" : 42290, "44" : 42870, "45" : 43449, "46" : 44028, "47" : 46345, "48" : 48663,
        "49" : 50979, "50" : 52139
    ]
    
    static var tariffNumbers: [Int] {
        tariff.keys.map { Int($0) ?? 0}.sorted()
    }
}
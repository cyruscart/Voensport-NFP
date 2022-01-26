//
//  DataFetcher.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.01.2022.
//

import Foundation

class DataFetcher {
    
    func getDataFromJSON(file name: String) -> Data? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
        
        do {
            guard let data = try String(contentsOfFile: path).data(using: .utf8) else { return nil }
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

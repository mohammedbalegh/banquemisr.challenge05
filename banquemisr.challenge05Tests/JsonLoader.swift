//
//  JsonLoader.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohammed Balegh on 17/03/2024.
//

import Foundation
@testable import banquemisr_challenge05

class JsonReader {
    
    func loadJson<T: Decodable>(fileName: String,  model: T.Type) -> T? {
        guard let path = Bundle(for: type(of:  self)).path(forResource: fileName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let symbolsModel = try? decoder.decode(T.self, from: data)
        return symbolsModel
    }
    
}

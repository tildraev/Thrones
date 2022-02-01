//
//  Character.swift
//  Thrones
//
//  Created by Arian Mohajer on 2/1/22.
//

import Foundation

class Character {
    let name: String
    let gender: String
    let culture: String
    
    init?(characterDictionary: [String:Any]) {
        guard let name = characterDictionary["name"] as? String,
              let gender = characterDictionary["gender"] as? String,
              let culture = characterDictionary["culture"] as? String else { return nil }
        self.name = name.isEmpty ? "Unnamed Character" : name
        self.gender = gender
        self.culture = culture
    }
}

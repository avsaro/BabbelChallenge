//
//  WordPair.swift
//  BabbelChallenge
//
//  Created by Onur Avsar on 22.07.2022.
//

import Foundation

class WordPair: Codable {
    
    public var english: String?
    public var spanish: String?
    
    private enum CodingKeys: String, CodingKey {
        case english = "text_eng"
        case spanish = "text_spa"
    }
    
}

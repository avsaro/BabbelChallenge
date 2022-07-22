//
//  WordsManager.swift
//  BabbelChallenge
//
//  Created by Onur Avsar on 22.07.2022.
//

import Foundation

class WordsManager {
    
    var jsonDecoder: JSONDecoder
    var wordPairs: [WordPair]
    
    //TODO: add game config
    init() {
        jsonDecoder = JSONDecoder()
        wordPairs = []
        let jsonData = readDataFromBundle()
        let wordPairs = decodeJSONFromData(jsonData)
        self.wordPairs = wordPairs ?? []
    }
    
    private func readDataFromBundle() -> Data? {
        if let url = Bundle.main.url(forResource: "words", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error: \(error)")
            }
        }
        return nil
    }
    
    private func decodeJSONFromData(_ jsonData: Data?) -> [WordPair]? {
        if let jsonData = jsonData {
            do {
                let wordPairs = try jsonDecoder.decode([WordPair].self, from: jsonData)
                return wordPairs
            } catch {
                print("error: \(error)")
            }
        }
        return nil
    }
    
}

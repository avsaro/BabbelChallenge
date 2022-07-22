//
//  WordsManager.swift
//  BabbelChallenge
//
//  Created by Onur Avsar on 22.07.2022.
//

import Foundation

class WordsManager {
    
    let gameConfigs: GameConfigs
    
    var jsonDecoder: JSONDecoder
    var wordPairs: [WordPair]
    
    var amountInProbabilityRound: UInt = 0
    var correctAmountInProbabilityRound: UInt = 0
    
    init(_ gameConfigs: GameConfigs) {
        self.gameConfigs = gameConfigs
        jsonDecoder = JSONDecoder()
        wordPairs = []
        let jsonData = readData(from: gameConfigs.dataFileName)
        let wordPairs = decodeJSON(from: jsonData)
        self.wordPairs = wordPairs ?? []
    }
    
    private func readData(from fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error: \(error)")
            }
        }
        return nil
    }
    
    private func decodeJSON(from jsonData: Data?) -> [WordPair]? {
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
    
    public func getQuizPair() -> QuizPair  {
        if amountInProbabilityRound == gameConfigs.probabilityRoundAmount {
            resetProbabilityRound()
        }
        
        // Always return wrong pair when maximum correct pair limit reached
        if correctAmountInProbabilityRound == gameConfigs.correctPairPerProbabilityRoundAmount {
            return prepareWrongPair()
        }
        
        // Always return correct pair when maximum wrong pair limit reached
        let wrongAmountInProbabilityRound = amountInProbabilityRound - correctAmountInProbabilityRound
        let requiredWrongAmountInProbabilityRound = gameConfigs.probabilityRoundAmount - gameConfigs.correctPairPerProbabilityRoundAmount
        if wrongAmountInProbabilityRound == requiredWrongAmountInProbabilityRound {
            return prepareCorrectPair()
        }
        
        // Randomize returned pair when no limit reached
        let randomInt = UInt.random(in: 0..<gameConfigs.probabilityRoundAmount)
        if randomInt < gameConfigs.correctPairPerProbabilityRoundAmount {
            return prepareCorrectPair()
        } else {
            return prepareWrongPair()
        }
    }
    
    private func resetProbabilityRound() {
        amountInProbabilityRound = 0
        correctAmountInProbabilityRound = 0
    }
    
    private func prepareCorrectPair() -> QuizPair {
        amountInProbabilityRound += 1
        correctAmountInProbabilityRound += 1
        let randomIndex = Int.random(in: 0..<wordPairs.count)
        let wordPair = wordPairs[randomIndex]
        let quizPair = QuizPair(englishWord: wordPair.english!, spanishWord: wordPair.spanish!, resultType: .correct)
        return quizPair
    }
    
    private func prepareWrongPair() -> QuizPair {
        amountInProbabilityRound += 1
        let randomIndex = Int.random(in: 0..<wordPairs.count)
        let wordPair = wordPairs[randomIndex]
        let wrongIndex = (randomIndex + Int(gameConfigs.wrongAnswerOffset)) % wordPairs.count
        let wrongPair = wordPairs[wrongIndex]
        let quizPair = QuizPair(englishWord: wordPair.english!, spanishWord: wrongPair.spanish!, resultType: .wrong)
        return quizPair
    }
    
}

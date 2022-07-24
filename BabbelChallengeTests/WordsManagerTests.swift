//
//  WordsManagerTests.swift
//  BabbelChallengeTests
//
//  Created by Onur Avsar on 24.07.2022.
//

import XCTest
@testable import BabbelChallenge

class WordsManagerTests: XCTestCase {
    
    var wordsManager: WordsManager!

    override func setUpWithError() throws {
        let gameConfigs = GameConfigs(dataFileName: "words", probabilityRoundAmount: 4, correctPairPerProbabilityRoundAmount: 1, wrongAnswerOffset: 1)
        wordsManager = WordsManager(gameConfigs)
    }

    override func tearDownWithError() throws {
        wordsManager = nil
    }
    
    func getQuizPairXTime(amount: UInt) -> (Int, Int) {
        var quizPairList = [QuizPair]()
        for _ in 0..<amount {
            quizPairList.append(wordsManager.getQuizPair())
        }
        var correctResultAmount = 0
        var wrongResultAmount = 0
        for quizPair in quizPairList {
            if quizPair.resultType == .correct {
                correctResultAmount += 1
            } else if quizPair.resultType == .wrong {
                wrongResultAmount += 1
            }
        }
        return (correctResultAmount, wrongResultAmount)
    }

    func testInit() throws {
        XCTAssertTrue((wordsManager as Any) is WordsManager)
        XCTAssertNotNil(wordsManager.gameConfigs)
        XCTAssertNotNil(wordsManager.jsonDecoder)
        XCTAssertNotNil(wordsManager.wordPairs)
        XCTAssertGreaterThan(wordsManager.wordPairs.count, 0)
    }
    
    func testReset() throws {
        wordsManager.amountInProbabilityRound = 8
        wordsManager.correctAmountInProbabilityRound = 5
        wordsManager.resetManager()
        XCTAssertEqual(wordsManager.amountInProbabilityRound, 0)
        XCTAssertEqual(wordsManager.correctAmountInProbabilityRound, 0)
    }
    
    func testGetQuizPairSingle() throws {
        let quizPair = wordsManager.getQuizPair()
        XCTAssertTrue((quizPair as Any) is QuizPair)
        XCTAssertNotNil(quizPair.englishWord)
        XCTAssertNotNil(quizPair.spanishWord)
        XCTAssertNotNil(quizPair.resultType)
        XCTAssertGreaterThan(quizPair.englishWord.count, 0)
        XCTAssertGreaterThan(quizPair.spanishWord.count, 0)
    }
    
    func testGetQuizPairFourTime() throws {
        let (correctResultAmount, wrongResultAmount) = getQuizPairXTime(amount: 4)
        
        XCTAssertEqual(correctResultAmount, 1)
        XCTAssertEqual(wrongResultAmount, 3)
    }
    
    func testGetQuizPairTwentyTime() throws {
        let (correctResultAmount, wrongResultAmount) = getQuizPairXTime(amount: 20)
        
        XCTAssertEqual(correctResultAmount, 5)
        XCTAssertEqual(wrongResultAmount, 15)
    }
    
    func testGetQuizPairTwoHundredTime() throws {
        let (correctResultAmount, wrongResultAmount) = getQuizPairXTime(amount: 200)
        
        XCTAssertEqual(correctResultAmount, 50)
        XCTAssertEqual(wrongResultAmount, 150)
    }
    
    func testGetQuizPairNineTime() throws {
        let (correctResultAmount, wrongResultAmount) = getQuizPairXTime(amount: 9)
        
        XCTAssertGreaterThanOrEqual(correctResultAmount, 2)
        XCTAssertGreaterThanOrEqual(wrongResultAmount, 6)
        XCTAssertLessThanOrEqual(correctResultAmount, 3)
        XCTAssertLessThanOrEqual(wrongResultAmount, 7)
    }

}

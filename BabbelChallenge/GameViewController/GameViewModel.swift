//
//  GameViewModel.swift
//  BabbelChallenge
//
//  Created by Onur Avsar on 22.07.2022.
//

import Foundation

class GameViewModel: GameViewModelProtocol {
    
    var changeHandler: ((GameViewModelChange) -> Void)?
    
    var correctAttempts: Int
    var wrongAttempts: Int
    var roundTimeInterval: TimeInterval
    
    var currentQuizPair: QuizPair?
    
    let wordsManager: WordsManager
    
    init() {
        correctAttempts = 0
        wrongAttempts = 0
        roundTimeInterval = 5.0
        let gameConfigs = GameConfigs(dataFileName: "words", probabilityRoundAmount: 4, correctPairPerProbabilityRoundAmount: 1, wrongAnswerOffset: 1)
        wordsManager = WordsManager(gameConfigs)
    }
    
    func gameStarted() {
        startNewRound()
    }
    
    func roundCompleted(withResponse response: QuizPair.ResultType?) {
        guard let currentQuizPair = currentQuizPair else {
            return
        }
        
        if let resultType = response {
            resultType == currentQuizPair.resultType ? (correctAttempts += 1) : (wrongAttempts += 1)
        } else {
            wrongAttempts += 1
        }
        
        emit(.statsUpdated)
        
        if isMaxWrongAttemptsReached() || isMaxTotalAttemptsReached() {
            emit(.gameEnded)
            return
        }
        
        startNewRound()
    }
    
    private func startNewRound() {
        let quizPair = wordsManager.getQuizPair()
        currentQuizPair = quizPair
        emit(.roundStarted(quizPair: quizPair))
    }
    
    private func emit(_ change: GameViewModelChange) {
        changeHandler?(change)
    }
    
    private func isMaxWrongAttemptsReached() -> Bool {
        return wrongAttempts >= 3
    }
    
    private func isMaxTotalAttemptsReached() -> Bool {
        return correctAttempts + wrongAttempts >= 15
    }
}

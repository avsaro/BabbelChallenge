//
//  GameViewModelProtocol.swift
//  BabbelChallenge
//
//  Created by Onur Avsar on 22.07.2022.
//

import Foundation

enum GameViewModelChange {
    
    case roundStarted(quizPair: QuizPair)
    case statsUpdated
    case gameEnded(gameWon: Bool)
    
}

protocol GameViewModelProtocol {
    
    var changeHandler: ((GameViewModelChange) -> Void)? { get set }
    var correctAttempts: Int { get }
    var wrongAttempts: Int { get }
    var roundTimeInterval: TimeInterval { get }
    
    func gameStarted()
    func gameRestarted()
    func roundCompleted(withResponse response: QuizPair.ResultType?)
    
}

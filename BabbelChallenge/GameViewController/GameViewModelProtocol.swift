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
    
}

protocol GameViewModelProtocol {
    
    var changeHandler: ((GameViewModelChange) -> Void)? { get set }
    var correctAttempts: Int { get }
    var wrongAttempts: Int { get }
    
    func gameStarted()
    func roundCompleted(withResponse response: QuizPair.ResultType)
    
}

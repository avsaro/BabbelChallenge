//
//  QuizPair.swift
//  BabbelChallenge
//
//  Created by Onur Avsar on 22.07.2022.
//

import Foundation

class QuizPair {
    
    let englishWord: String
    let spanishWord: String
    let resultType: ResultType
    
    init(englishWord: String, spanishWord: String, resultType: ResultType) {
        self.englishWord = englishWord
        self.spanishWord = spanishWord
        self.resultType = resultType
    }
    
    enum ResultType {
        case correct, wrong
    }
    
}

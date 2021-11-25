//
//  GameRound.swift
//  Right on Target
//
//  Created by David Sergeev on 24.11.2021.
//

import Foundation

protocol GameRoundProtocol {
    // Количество заработанных за раунд очков
    var score: Int { get }
    // Текущее загаданное число
    var currentSecretValue: Int! { get }
    
    // Подсчёт очков за раунд
    func calculateScore(with value: Int)
}


class GameRound: GameRoundProtocol {
    var score: Int = 0
    var currentSecretValue: Int! = 0
    init(secretValue: Int) {
        currentSecretValue = secretValue
    }
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
}

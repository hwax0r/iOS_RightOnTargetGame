//
//  Game.swift
//  Right on Target
//
//  Created by David Sergeev on 23.11.2021.
//

import Foundation

protocol GameProtocol {
    // Количество заработанных очков
    var score: Int { get }
    // Генератор случайных значений
    var secretValueGenerator: GeneratorProtocol { get }
    // Текущий раунд
    var currentRound: GameRoundProtocol! { get }
    // флаг, определяющий закончилась ли игра
    var isGameEnded: Bool { get }
    
    // Начинает игру и запускает 1 раунд
    func restartGame()
    // Начинает новый раунд(обновляет загаданное число)
    func startNewRound()
}


class Game: GameProtocol {
    
    var score: Int {
        var totalScore: Int = 0
        for round in self.rounds {
            totalScore += round.score
        }
        return totalScore
    }
    
    var currentRound: GameRoundProtocol!
    private var rounds: [GameRoundProtocol] = []
    
    var secretValueGenerator: GeneratorProtocol
    
    private var roundsCount: Int!
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }
    
    init(valueGenerator: GeneratorProtocol, rounds: Int){
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    
    func restartGame() {
        rounds = []
        startNewRound()
    }
    
    func startNewRound() {
        let newSecretValue = getNewSecretValue()
        currentRound = GameRound(secretValue: newSecretValue)
        rounds.append(currentRound)
    }
    
    func getNewSecretValue() -> Int {
        return secretValueGenerator.getRandomValue()
    }
    
}

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
    // текущее загаданное число
    var currentSecretValue: Int { set get }
    // флаг, определяющий закончилась ли игра
    var isGameEnded: Bool { set get }
    
    // Начинает игру и запускает 1 ранд
    func restartGame()
    // Начинает новый раунд(обновляет загаданное число)
    func startNewRound()
    // Сравнивает переданное значение с загаданным и начисляет очки
    func calculateScore(with value: Int)
}

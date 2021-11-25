//
//  Generator.swift
//  Right on Target
//
//  Created by David Sergeev on 24.11.2021.
//

import Foundation

protocol GeneratorProtocol {
    func getRandomValue() -> Int
}


class Generator: GeneratorProtocol {
    
    private let startRangeValue: Int
    private let endRangeValue: Int
    
    init?(startValue: Int, endValue: Int){
        // Стартовое значение для выбора случайного числа не может быть больше конечного
        guard startValue <= endValue else {
            return nil
        }
        
        startRangeValue = startValue
        endRangeValue = endValue
    }
    
    func getRandomValue() -> Int {
        return (startRangeValue...endRangeValue).randomElement()!
    }
}

//
//  Generator.swift
//  Right on Target
//
//  Created by David Sergeev on 24.11.2021.
//

import Foundation
import UIKit

protocol GeneratorProtocol {
    func getRandomValue() -> Int
}


class NumberGenerator: GeneratorProtocol {
    
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

class HexColorGenerator: GeneratorProtocol {
    /*
     Class generates HEX color of format #000000...FFFFFF
     */
    
    var rNorm: CGFloat = 0.0
    var gNorm: CGFloat = 0.0
    var bNorm: CGFloat = 0.0
    
    init() {}
    
    func getRandomValue() -> Int {
        let red   = (0...255).randomElement()!
        let green = (0...255).randomElement()!
        let blue  = (0...255).randomElement()!
        
        rNorm = CGFloat(red)/255
        gNorm = CGFloat(green)/255
        bNorm = CGFloat(blue)/255
        
        let hexColor: Int = red<<16 | green<<8 | blue<<0
        
        return hexColor
    }
}

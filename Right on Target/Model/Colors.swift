//
//  Colors.swift
//  Right on Target
//
//  Created by David Sergeev on 27.11.2021.
//

import Foundation
import UIKit

protocol ColorGameProtocol {
    // Количество заработанных очков
    var score: Int { get }
    //
    var rounds: Int { get }
    // Генератор случайных значений
    var secretValueGenerator: HexColorGenerator { get }
    // Загаданное значение
    var secretValue: UIColor! { get }
    
    // Начало нового раунда
    func newRound()
    // Подсчитывает очки и начинает новый раунд
    func compareAnswer(with: UIButton)
}

class colorGame: ColorGameProtocol {
    var score: Int = 0
    var rounds: Int = 0
    
    internal var secretValueGenerator = HexColorGenerator()
    var secretValue: UIColor!
    internal var buttonColors: [UIColor] = []
    internal var buttons: [UIButton] = []
    
    init(from buttons: [UIButton]) {
        self.buttons = buttons
        newRound()
    }
    
    func newRound() {
        buttonColors = []
        generateRandomColors()
        selectSecretValue()
    }
    
    func compareAnswer(with button: UIButton) {
        rounds += 1
        if button.title(for: .normal) == secretValue.hexString {
            score += 1
        } else {
            guard score >= 1 else {
                score = 0
                return
            }
            score -= 1
        }
    }
    
    private func generateRandomColors(){
        for button in buttons {
            let newSecretValue: Int = secretValueGenerator.getRandomValue()
            let normColors = secretValueGenerator.getRGBNormed()
            let buttonColor: UIColor = colorRGBToUIColor(rNorm: normColors!.0,
                                                         gNorm: normColors!.1,
                                                         bNorm: normColors!.2)
            let buttonText: String = colorIntToHexString(randomColor: newSecretValue)
            
            button.setTitle(buttonText, for: .normal)
            buttonColors.append(buttonColor)
        }
    }
    
    private func selectSecretValue(){
        let randomIndex: Int = (0..<buttonColors.count).randomElement()!
        secretValue = buttonColors[randomIndex]
    }
    
    private func colorRGBToUIColor(rNorm: CGFloat, gNorm: CGFloat, bNorm: CGFloat) -> UIColor {
            let color = UIColor(red: rNorm,
                                green: gNorm,
                                blue: bNorm,
                                alpha: 1)
            return color
        }
    
    private func colorIntToHexString(randomColor color: Int) -> String {
            var hexString = NSString(format:"#%06x", color) as String
            hexString = hexString.uppercased()
            return hexString
        }
}

class HexColorGenerator: GeneratorProtocol {
    /*
     Class generates HEX color of format #000000...FFFFFF
     */
    
    private var rNorm: CGFloat? = nil
    private var gNorm: CGFloat? = nil
    private var bNorm: CGFloat? = nil
    
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
    
    func getRGBNormed() -> (CGFloat, CGFloat, CGFloat)? {
        guard rNorm != nil else {
            return nil
        }
        return (rNorm!, gNorm!, bNorm!)
    }
}

extension UIColor {
    var hexString: String {
        cgColor.components![0..<3]
            .map { String(format: "%02lX", Int($0 * 255)) }
            .reduce("#", +)
    }
}

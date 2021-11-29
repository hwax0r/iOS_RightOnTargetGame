//
//  Colors.swift
//  Right on Target
//
//  Created by David Sergeev on 27.11.2021.
//

import Foundation
import UIKit

protocol ColorsGameProtocol {
    // Генератор цветов
    var colorGenerator: HexColorGenerator { get }
    // Массив кнопок
    var buttons: [UIButton] { get }
    // Загаданый цвет
    var secretColor: UIColor { get }
    var secretLabel: UILabel { get }
    
    // Получает вывод генератора и преобразует его в Hex-значение цвета
    func colorIntToHexString(randomColor color: Int) -> String
    // Получает вывод генератора и преобразует его в UIColor
    func colorRGBToUIColor(rNorm: CGFloat, gNorm: CGFloat, bNorm: CGFloat) -> UIColor
    // Сравнивает загаданный цвет с выбранным на кнопке
    func isCorrectAnswer(button: UIButton) -> Bool
    
    init?(buttons: [UIButton], secretLabel: UILabel)
}

class colorsGame: ColorsGameProtocol {
    var colorGenerator = HexColorGenerator()
    var buttons: [UIButton] = []
    var secretLabel = UILabel()
    var secretColor = UIColor()
    
    required init?(buttons: [UIButton], secretLabel: UILabel) {
        guard buttons != [] else {
            return nil
        }
        self.buttons = buttons
        self.secretLabel = secretLabel
    }
    
    func colorIntToHexString(randomColor color: Int) -> String {
        var hexString = NSString(format:"#%06x", color) as String
        hexString = hexString.uppercased()
        return hexString
    }
    
    func colorRGBToUIColor(rNorm: CGFloat, gNorm: CGFloat, bNorm: CGFloat) -> UIColor {
        let color = UIColor(red: rNorm,
                            green: gNorm,
                            blue: bNorm,
                            alpha: 1)
        return color
    }
    
    func isCorrectAnswer(button: UIButton) -> Bool{
        secretColor == button.backgroundColor
    }
    
    
    
    func newRound(){
        for button in buttons {
            let color: Int = colorGenerator.getRandomValue()
            let colorName: String = self.colorIntToHexString(randomColor: color)
            button.backgroundColor = self.colorRGBToUIColor(rNorm: colorGenerator.rNorm,
                                                            gNorm: colorGenerator.gNorm,
                                                            bNorm: colorGenerator.bNorm)
            button.setTitle(colorName, for: .normal)
        }
        
        let randomIndex: Int = (0...3).randomElement()!
        secretColor = buttons[randomIndex].backgroundColor!
        secretLabel.text = buttons[randomIndex].backgroundColor!.hexString
    }
}

extension UIColor {
    var hexString: String {
        cgColor.components![0..<3]
            .map { String(format: "%02lX", Int($0 * 255)) }
            .reduce("#", +)
    }
}

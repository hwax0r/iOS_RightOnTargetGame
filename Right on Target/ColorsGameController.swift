//
//  ColorsGameController.swift
//  Right on Target
//
//  Created by David Sergeev on 27.11.2021.
//

import UIKit

class ColorsGameController: UIViewController {
    // Экземпляр игры
    var game: colorGame!
    
    // Метка со значением score
    @IBOutlet var scoreLabel: UILabel!
    // Метка с кол-вом раундов
    @IBOutlet var roundsLabel: UILabel!
    
    // Кнопки слева направо
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!

    @IBAction func didPressButton(_ sender: UIButton){
        // Передача значения кнопки в игру для проверки
        game.compareAnswer(with: sender)
        scoreLabel.text = "Score: \(game.score)"
        roundsLabel.text = "Rounds: \(game.rounds)"
        game.newRound()
    }
    
    override func loadView() {
        super.loadView()
        // добавление рамок для кнопок
        let buttons = [button1!, button2!, button3!, button4!]
        for button in buttons {
            button.setBordersSettings()
            button.backgroundColor = UIColor.white
        }
        // Инициализация игры
        game = colorGame(from: buttons)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.newRound()
    }
}

fileprivate extension UIButton {
    func setBordersSettings() {
        let borderColor = (UIColor.black)
        self.layer.borderWidth = 0.1
        self.layer.cornerRadius = 3
        self.layer.borderColor = borderColor.cgColor
        self.setTitleColor(borderColor, for: .normal)
        self.layer.masksToBounds = true
    }
}

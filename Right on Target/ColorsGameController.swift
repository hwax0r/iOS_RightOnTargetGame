//
//  ColorsGameController.swift
//  Right on Target
//
//  Created by David Sergeev on 27.11.2021.
//

import UIKit

class ColorsGameController: UIViewController {
    // Экземпляр игры
    var game: colorsGame!
    
    // Метка с HEX значением текущего загаданного цвета
    @IBOutlet var hexLabel: UILabel!
    
    // Кнопки слева направо
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    // Нажатая кнопка
    var pressedButton: UIButton?
    
    @IBAction func didPressButton(_ sender: UIButton){
        print("Button: \(sender.title(for: .normal))")
        pressedButton = sender
        
        if pressedButton != nil {
            print("Button pressed")
            if game.isCorrectAnswer(button: pressedButton!) {
                print("OK")
                game.newRound()
                view.backgroundColor = game.secretColor
            } else {
                print("NO")
            }
            print()
        }
    }
    
    override func loadView() {
        super.loadView()
        game = colorsGame(buttons: [button1, button2, button3, button4],
                          secretLabel: hexLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.newRound()
        view.backgroundColor = game.secretColor
    }

    
}

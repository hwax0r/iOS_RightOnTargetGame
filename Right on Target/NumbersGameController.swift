//
//  ViewController.swift
//  Right on Target
//
//  Created by David Sergeev on 17.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // Сущность игры
    var game: Game!
    
    // Элементы сцены
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!

    // MARK: Жизненный цикл
    
    override func loadView() {
        super.loadView()
        
        // метка для вывода номера версии
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
        
        // текущий номер версии
        let applicationVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        // изменяеим текст метки
        versionLabel.text = "Версия \(applicationVersion)"
        // добавляем метку в родительский View
        view.addSubview(versionLabel)
        
        // Установка бегунка слайдера на середину
        slider.value = 25
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Генератор случайных чисел
        let generator = NumberGenerator(startValue: 1, endValue: 50)!
        
        // Экземпляр сущности "Игра"
        game = Game(valueGenerator: generator, rounds: 5)
        
        // Обновление текста метки на текущее загаданное число
        updateLabelWithSecretNumber(newSecretNumber: game.currentRound.currentSecretValue)
    }
    
    // MARK: Взаимодействие View - Model
    
    @IBAction func checkNumber() {
        // Подсчёт очков за раунд
        game.currentRound.calculateScore(with: Int(slider.value))
        
        // Проверка окончания игры
        if game.isGameEnded {
            // Показ окна с результатами
            showAlertWith(score: game.score)
            // Запуск новой игры
            game.restartGame()
        } else {
            game.startNewRound()
        }
       
        // Обновление текста метки на новое загаданное число
        updateLabelWithSecretNumber(newSecretNumber: game.currentRound.currentSecretValue)
    }
    
    // Отображение всплывающего окна со счётом
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена",
                                      message: "Вы набрали \(score) очков",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Начать заново",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // Обновление текста метки новым загаданным числом
    private func updateLabelWithSecretNumber(newSecretNumber: Int) {
        label.text = String(newSecretNumber)
    }
    
}

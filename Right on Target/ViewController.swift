//
//  ViewController.swift
//  Right on Target
//
//  Created by David Sergeev on 17.11.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    // загаданное число
    var number: UInt8 = 0
    // номер раунда
    var round: UInt8 = 1
    // количество заработанных очков
    var points: Int = 0
    
    override func loadView() {
        super.loadView()
        print("loadView")
        
        // метка для вывода номера версии
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
        // изменяеим текст метки
        versionLabel.text = "Версия 1.1"
        // добавляем метку в родительский View
        view.addSubview(versionLabel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        // генерация случайного числа
        number = UInt8.random(in: 1...50)
        // смена текста метки на загаданное число
        label.text = String(number)
        
        // значение слайдера установлено в сториборде
        // на середину - 25 и отображается там правильно,
        // но в симуляторе при запуске приложения значение на 1 ???
        // непонятно (в туториале вроде всё ок)
        slider.value = 25
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    @IBAction func checkNumber() {
        // получаем чило, на которое установлен ползунок слайдера
        let numSlider = UInt8(slider.value.rounded())
        
        // сравниваем значение с загаданным и считаем очки
        if numSlider > number {
            points += 25 - Int(numSlider) + Int(number)
        } else if numSlider < number {
            points += 25 - Int(number) + Int(numSlider)
        } else {
            points += 25
        }
        
        // окончание игры по истечении 5 раундов
        if round == 5 {
            // вывод информационного окна с итогами игры
            let alert = UIAlertController(title: "Игра окончена",
                                          message: "Вы заработали \(points) очков",
                                          preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "Начать заново",
                              style: .default,
                              handler: nil))
            present(alert, animated: true, completion: nil)
            
            round = 1
            points = 0
        } else {
            round += 1
        }
        
        number = UInt8.random(in: 1...50)
        label.text = String(number)
    }
    
    @IBAction func showNextScreen(){
        // загрузка storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // загрузка viewController и его сцены со storyboard
        let viewController = storyboard.instantiateViewController(identifier: "SecondViewController")
        // отображение сцены на экране
        self.present(viewController, animated: true, completion: nil)
    }

}


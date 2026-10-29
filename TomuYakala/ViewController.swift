//
//  ViewController.swift
//  TomuYakala
//
//  Created by Efe Keles on 22.10.2026.
//

import UIKit

class ViewController: UIViewController {
    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var tomArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    //Wiews
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var tom1: UIImageView!
    @IBOutlet weak var tom2: UIImageView!
    @IBOutlet weak var tom3: UIImageView!
    @IBOutlet weak var tom4: UIImageView!
    @IBOutlet weak var tom5: UIImageView!
    @IBOutlet weak var tom6: UIImageView!
    @IBOutlet weak var tom7: UIImageView!
    @IBOutlet weak var tom8: UIImageView!
    @IBOutlet weak var tom9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)" // üzerine dokunmayı aktıf hale getırıyor
        
        //highScore chech
        
        let storedHighScored = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScored == nil {
            highScore = 0
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        
        if let newScore = storedHighScored as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        
        
        //images
        tom1.isUserInteractionEnabled = true
        tom2.isUserInteractionEnabled = true
        tom3.isUserInteractionEnabled = true
        tom4.isUserInteractionEnabled = true
        tom5.isUserInteractionEnabled = true
        tom6.isUserInteractionEnabled = true
        tom7.isUserInteractionEnabled = true
        tom8.isUserInteractionEnabled = true
        tom9.isUserInteractionEnabled = true
        
        //recognızer ekrana teması algılar yapılan işlemi algılar.Kullanıcı ekrana veya bir görsele dokunduğunda çalışır. Örneğin, hesap makinesindeki + butonuna basılması.
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        tom1.addGestureRecognizer(recognizer1)
        tom2.addGestureRecognizer(recognizer2)
        tom3.addGestureRecognizer(recognizer3)
        tom4.addGestureRecognizer(recognizer4)
        tom5.addGestureRecognizer(recognizer5)
        tom6.addGestureRecognizer(recognizer6)
        tom7.addGestureRecognizer(recognizer7)
        tom8.addGestureRecognizer(recognizer8)
        tom9.addGestureRecognizer(recognizer9)
        
        tomArray = [tom1, tom2, tom3, tom4, tom5, tom6, tom7, tom8, tom9]

        
        //Timers
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidetom), userInfo: nil, repeats: true)
        
        hidetom()
        
        
    }
    
        @objc func hidetom() {
         
        for tom in tomArray {
            tom.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(tomArray.count - 1)))
        tomArray[random].isHidden = false
        
        
        
    }
    
    
    
//increase sayıyı arttırmakta kullanılır decrase sayıyı azaltmakta kullanılır.
  @objc func increaseScore() {
      score += 1
      scoreLabel.text = "Score : \(score)"
        
    }
    
    @objc func  countDown(){
        
         counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for tom in tomArray {
                tom.isHidden = true
            }
            
            //HıghScore
           
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "highScore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
                
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Zaman Doldu", message: "Tekrar Oynamak İster misiniz?", preferredStyle: UIAlertController.Style.alert )
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel , handler:nil)
                
            let replayButton = UIAlertAction(title: "REPLAY", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                //replay functıon
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hidetom), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }
}


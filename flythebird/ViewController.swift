//
//  ViewController.swift
//  flythebird
//
//  Created by Emre Ozturk on 6.12.2022.
//

import UIKit


class ViewController: UIViewController {
    var birdArray = [UIImageView]()
    
        var score = 0
    
    
    
    var timer = Timer()
    var hideTimer = Timer()
    var highScore = 0
    @IBOutlet weak var timerLabel: UILabel!
    var counter = 30
    
    @IBOutlet weak var zamanlayici: UILabel!
    
    @IBOutlet weak var liveScorLabel: UILabel!
    @IBOutlet weak var bird1: UIImageView!
    @IBOutlet weak var bird2: UIImageView!
    @IBOutlet weak var bird3: UIImageView!
    @IBOutlet weak var bird4: UIImageView!
    @IBOutlet weak var bird5: UIImageView!
    @IBOutlet weak var bird6: UIImageView!
    @IBOutlet weak var bird7: UIImageView!
    @IBOutlet weak var bird8: UIImageView!
    @IBOutlet weak var bird9: UIImageView!
    
    @IBOutlet weak var totalScorelABEL: UILabel!
    
    override func viewDidLoad() {
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil
        {
            highScore = 0
            totalScorelABEL.text = "Highscore : \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            totalScorelABEL.text = "Highscore : \(highScore)"
        }
        
        
        super.viewDidLoad()
        score = 0
        liveScorLabel.text = "Score : \(score)"
        
        bird1.isUserInteractionEnabled = true
        bird2.isUserInteractionEnabled = true
        bird3.isUserInteractionEnabled = true
        bird4.isUserInteractionEnabled = true
        bird5.isUserInteractionEnabled = true
        bird6.isUserInteractionEnabled = true
        bird7.isUserInteractionEnabled = true
        bird8.isUserInteractionEnabled = true
        bird9.isUserInteractionEnabled = true
 
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        
        bird1.addGestureRecognizer(recognizer1)
        bird2.addGestureRecognizer(recognizer2)
        bird3.addGestureRecognizer(recognizer3)
        bird4.addGestureRecognizer(recognizer4)
        bird5.addGestureRecognizer(recognizer5)
        bird6.addGestureRecognizer(recognizer6)
        bird7.addGestureRecognizer(recognizer7)
        bird8.addGestureRecognizer(recognizer8)
        bird9.addGestureRecognizer(recognizer9)
        
        birdArray = [bird1,bird2,bird3,bird4,bird5,bird6,bird7,bird8,bird9]
        
        counter = 15
        zamanlayici.text = ("\(counter)")
        liveScorLabel.text = "Score : \(score)"
        zamanlayici.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
       
        hideBird()
        hideTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(hideBird), userInfo: nil, repeats: true)
    }
    @objc func hideBird()
    {
        for bird in birdArray {
            bird.isHidden = true
        }
        
      let random = Int(arc4random_uniform(UInt32(birdArray.count-1)))
        birdArray[random].isHidden = false
    }
    
    
    @objc func increaseScore()
    {
        score += 5
        liveScorLabel.text = "Score : \(score)"
    }

    @objc func countDown()
    {
        counter -= 1
        zamanlayici.text = "\(counter)"
        
        if counter < 1
        {
            timer.invalidate()
            hideTimer.invalidate()
            
            
            if self.score > self.highScore{
                self.highScore = self.score
                totalScorelABEL.text = "Highscore : \(highScore)"
                UserDefaults.standard.set(self.highScore,forKey: "highscore")
            }
            
                    
            
            
            
            for bird in birdArray {
                       bird.isHidden = true
                   }
            
            let alert = UIAlertController(title: "Time Out", message: "Game Over...", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.liveScorLabel.text = "Score : \(self.score)"
                self.counter = 15
                self.zamanlayici.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                      
                       
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(self.hideBird), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}


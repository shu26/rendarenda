//
//  GameViewController.swift
//  Tekipaki
//
//  Created by 海法修平 on 2017/02/14.
//  Copyright © 2017年 Swift-Beginners. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  var timer:Timer?
  var count =  Float(0)
  let settingKey = "timer_value"
  
  var blueNum = Int(arc4random() % 7)
  var yellowNum = Int(arc4random() % 7)
  var redNum = Int(arc4random() % 7)
  
  var score = 0
  var gameCount = 0
  var trueCount = 0
  var answerCount = 0
  
  var blueButtonCount = 0
  var yellowButtonCount = 0
  var redButtonCount = 0
  
  var buttonArray = [0,0,0]
 
    override func viewDidLoad() {
      super.viewDidLoad()

        // Do any additional setup after loading the view.
      resetValue()
      let settings = UserDefaults.standard
      settings.register(defaults: [settingKey:60])
      
      timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  func displayUpdate() -> Float {
    
    let settings = UserDefaults.standard
    let timerValue = Float(settings.integer(forKey: settingKey))
    let remainCount = floor((timerValue - count)*10)/10
    countdownLabel.text = "\(remainCount)"
    return remainCount
    
  }
  
  func timerInterrupt(_ timer:Timer) {
    count += 0.1
    if displayUpdate() <= 0 {
      timer.invalidate()
      self.performSegue(withIdentifier: "toFinish", sender: nil)
    }
    
  }
  
  
  //青、黄、赤の画像をランダムに表示
  func imageControl ()  {
    
    print(blueNum,yellowNum,redNum,"ラベルの数")

    blueButtonCount=0
    yellowButtonCount=0
    redButtonCount=0
    
    var blueArray = [false,false,false,false,false,false]
    var yellowArray = [false,false,false,false,false,false]
    var redArray = [false,false,false,false,false,false]
    
    if blueNum != 6 {
      for i in blueNum+1...6 {
        blueArray[i-1] = true
      }
    }
    b01Image.isHidden = blueArray[0]
    b02Image.isHidden = blueArray[1]
    b03Image.isHidden = blueArray[2]
    b04Image.isHidden = blueArray[3]
    b05Image.isHidden = blueArray[4]
    b06Image.isHidden = blueArray[5]
    
    if yellowNum != 6 {
      for i in yellowNum+1...6 {
        yellowArray[i-1] = true
      }
    }
    y01Image.isHidden = yellowArray[0]
    y02Image.isHidden = yellowArray[1]
    y03Image.isHidden = yellowArray[2]
    y04Image.isHidden = yellowArray[3]
    y05Image.isHidden = yellowArray[4]
    y06Image.isHidden = yellowArray[5]
    
    if redNum != 6 {
      for i in redNum+1...6 {
        redArray[i-1] = true
      }
    }
    r01Image.isHidden = redArray[0]
    r02Image.isHidden = redArray[1]
    r03Image.isHidden = redArray[2]
    r04Image.isHidden = redArray[3]
    r05Image.isHidden = redArray[4]
    r06Image.isHidden = redArray[5]
    
    blueButtonOK.isEnabled = true
    yellowButtonOK.isEnabled = true
    redButtonOK.isEnabled = true
    
    print(blueButtonCount,yellowButtonCount,redButtonCount,"ボタンの押された数")
    
  }
  
  
  //リセット処理
  func resetValue() {
    print("resetValue()呼べてる")
    answerCount=0
    print("answerCount:\(answerCount)")
    gameCount+=1
    questionNumber.text = "第\(gameCount)問"
    answerLabel.isHidden=true
    if gameCount == 11 {
      print("FINISH")
      self.performSegue(withIdentifier: "toFinish", sender: nil)
      gameCount=0
    } else {
      repeat {
      blueNum = Int(arc4random() % 7)
      yellowNum = Int(arc4random() % 7)
      redNum = Int(arc4random() % 7)
      } while (blueNum==0)&&(yellowNum==0)&&(redNum==0)
      buttonArray=[0,0,0]
      
      b01Image.isHighlighted = false
      b02Image.isHighlighted = false
      b03Image.isHighlighted = false
      b04Image.isHighlighted = false
      b05Image.isHighlighted = false
      b06Image.isHighlighted = false
      y01Image.isHighlighted = false
      y02Image.isHighlighted = false
      y03Image.isHighlighted = false
      y04Image.isHighlighted = false
      y05Image.isHighlighted = false
      y06Image.isHighlighted = false
      r01Image.isHighlighted = false
      r02Image.isHighlighted = false
      r03Image.isHighlighted = false
      r04Image.isHighlighted = false
      r05Image.isHighlighted = false
      r06Image.isHighlighted = false
      
      imageControl()
    }
  }
  
  
  //ラベル表示
  func answer() {
    answerCount+=1
    answerLabel.isHidden = false
    blueButtonOK.isEnabled = false
    yellowButtonOK.isEnabled = false
    redButtonOK.isEnabled = false
    timer = Timer.scheduledTimer(timeInterval: 0.4,
                                 target: self,
                                 selector: #selector(GameViewController.resetValue),
                                 userInfo: nil,
                                 repeats: false)
  }
  
  
  //次画面に正解回数値を渡す
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let controller:FinishViewController = (segue.destination as? FinishViewController)!
    controller.message = trueCount
    controller.lastScore = score
    controller.remainTime = displayUpdate()
  }
  
  
  //青ボタン
  @IBAction func blueButton(_ sender: Any) {
    if answerCount==0 {
      blueButtonCount+=1
      print("青ボタン",blueButtonCount)
      if blueButtonCount==1 {
        b01Image.isHighlighted=true
      } else if blueButtonCount==2 {
        b02Image.isHighlighted=true
      } else if blueButtonCount==3 {
        b03Image.isHighlighted=true
      } else if blueButtonCount==4 {
        b04Image.isHighlighted=true
      } else if blueButtonCount==5 {
        b05Image.isHighlighted=true
      } else if blueButtonCount==6 {
        b06Image.isHighlighted=true
      }
      if blueButtonCount==blueNum {
      
        print("青OK")
        buttonArray[0] = 1
        if yellowNum==0 {
          buttonArray[1]=1
        }
        if redNum==0 {
          buttonArray[2]=1
        }
        if buttonArray == [1,1,1] {
          print("完了")
          answerLabel.text = "あたり！"
          trueCount+=1
          score+=20
          answer()
        }
      }
      else if blueButtonCount > blueNum {
      answerLabel.text = "ちがう！"
      score-=10
      answer()
      }
    }
  }
  
  //黄ボタン
  @IBAction func yellowButton(_ sender: Any) {
    if answerCount==0 {
      yellowButtonCount+=1
      print("黄ボタン",yellowButtonCount)
      if yellowButtonCount==1 {
        y01Image.isHighlighted=true
      } else if yellowButtonCount==2 {
        y02Image.isHighlighted=true
      } else if yellowButtonCount==3 {
        y03Image.isHighlighted=true
      } else if yellowButtonCount==4 {
        y04Image.isHighlighted=true
      } else if yellowButtonCount==5 {
        y05Image.isHighlighted=true
      } else if yellowButtonCount==6 {
        y06Image.isHighlighted=true
      }
      if yellowButtonCount==yellowNum {
      
        print("黄OK")
        buttonArray[1] = 1
        if blueNum==0 {
          buttonArray[0]=1
        }
        if redNum==0{
          buttonArray[2]=1
        }
        if buttonArray == [1,1,1] {
          print("完了")
          answerLabel.text = "あたり！"
          trueCount+=1
          score+=20
          answer()
        }
      }
      else if yellowButtonCount > yellowNum {
      answerLabel.text = "ちがう！"
      score-=10
      answer()
      }
    }
  }
  
  //赤ボタン
  @IBAction func redButton(_ sender: Any) {
    if answerCount==0 {
      redButtonCount+=1
      print("赤ボタン",redButtonCount)
      if redButtonCount==1 {
        r01Image.isHighlighted=true
      } else if redButtonCount==2 {
        r02Image.isHighlighted=true
      } else if redButtonCount==3 {
        r03Image.isHighlighted=true
      } else if redButtonCount==4 {
        r04Image.isHighlighted=true
      } else if redButtonCount==5 {
        r05Image.isHighlighted=true
      } else if redButtonCount==6 {
        r06Image.isHighlighted=true
      }
      if redButtonCount==redNum{
        print("赤OK")
        buttonArray[2] = 1
        if blueNum==0{
          buttonArray[0]=1
        }
        if yellowNum==0{
          buttonArray[1]=1
        }

        if buttonArray == [1,1,1] {
          print("完了")
          answerLabel.text = "あたり！"
          trueCount+=1
          score+=20
          answer()
        }
      } else if redButtonCount > redNum {
        answerLabel.text = "ちがう！"
        score-=10
        answer()
      }
    }
  }
  
  @IBOutlet weak var questionNumber: UILabel!
  
  @IBOutlet weak var blueButtonOK: UIButton!
  @IBOutlet weak var yellowButtonOK: UIButton!
  @IBOutlet weak var redButtonOK: UIButton!
  
  @IBOutlet weak var answerLabel: UILabel!
  
  @IBOutlet weak var b01Image: UIImageView!
  @IBOutlet weak var b02Image: UIImageView!
  @IBOutlet weak var b03Image: UIImageView!
  @IBOutlet weak var b04Image: UIImageView!
  @IBOutlet weak var b05Image: UIImageView!
  @IBOutlet weak var b06Image: UIImageView!

  @IBOutlet weak var y01Image: UIImageView!
  @IBOutlet weak var y02Image: UIImageView!
  @IBOutlet weak var y03Image: UIImageView!
  @IBOutlet weak var y04Image: UIImageView!
  @IBOutlet weak var y05Image: UIImageView!
  @IBOutlet weak var y06Image: UIImageView!

  @IBOutlet weak var r01Image: UIImageView!
  @IBOutlet weak var r02Image: UIImageView!
  @IBOutlet weak var r03Image: UIImageView!
  @IBOutlet weak var r04Image: UIImageView!
  @IBOutlet weak var r05Image: UIImageView!
  @IBOutlet weak var r06Image: UIImageView!
  
  @IBOutlet weak var countdownLabel: UILabel!
}

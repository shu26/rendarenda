//
//  CountdownViewController.swift
//  Tekipaki
//
//  Created by 海法修平 on 2017/02/14.
//  Copyright © 2017年 Swift-Beginners. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
  
  var timer : Timer?
  var count = 0
  let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      let settings = UserDefaults.standard
      settings.register(defaults: [settingKey:3])
      
      timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func displayUpdate() -> Int {
    
    let settings = UserDefaults.standard
    let timerValue = settings.integer(forKey: settingKey)
    let remainCount = timerValue - count
    countdownLabel.text = "\(remainCount)"
    return remainCount
    
  }
  
  
  func timerInterrupt(_ timer:Timer) {
    count += 1
    if displayUpdate() <= 0 {
      timer.invalidate()
      self.performSegue(withIdentifier: "toGame", sender: nil)
    }
  }
  
  @IBOutlet weak var countdownLabel: UILabel!
  
}

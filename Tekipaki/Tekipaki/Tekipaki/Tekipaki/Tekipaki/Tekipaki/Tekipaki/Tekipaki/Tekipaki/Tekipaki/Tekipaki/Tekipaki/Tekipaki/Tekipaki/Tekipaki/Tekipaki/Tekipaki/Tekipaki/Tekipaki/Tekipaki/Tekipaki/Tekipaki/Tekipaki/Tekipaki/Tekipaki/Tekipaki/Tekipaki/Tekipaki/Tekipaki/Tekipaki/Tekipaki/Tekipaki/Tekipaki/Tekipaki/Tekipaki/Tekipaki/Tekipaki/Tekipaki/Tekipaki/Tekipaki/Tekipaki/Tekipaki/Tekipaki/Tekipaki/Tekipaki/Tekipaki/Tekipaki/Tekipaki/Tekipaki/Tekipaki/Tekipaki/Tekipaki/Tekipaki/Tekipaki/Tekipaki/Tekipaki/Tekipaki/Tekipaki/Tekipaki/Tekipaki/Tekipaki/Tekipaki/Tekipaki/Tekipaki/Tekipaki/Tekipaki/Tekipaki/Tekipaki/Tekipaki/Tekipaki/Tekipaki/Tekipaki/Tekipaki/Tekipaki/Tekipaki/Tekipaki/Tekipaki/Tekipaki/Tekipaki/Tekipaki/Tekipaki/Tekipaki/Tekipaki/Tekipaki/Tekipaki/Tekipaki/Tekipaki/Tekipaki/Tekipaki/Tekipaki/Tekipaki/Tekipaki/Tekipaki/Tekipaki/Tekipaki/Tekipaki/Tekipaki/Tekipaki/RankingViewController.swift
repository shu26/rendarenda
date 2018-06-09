//
//  RankingViewController.swift
//  Tekipaki
//
//  Created by 海法修平 on 2017/02/17.
//  Copyright © 2017年 Swift-Beginners. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController//, UITableViewDelegate, UITableViewDataSource 
{

  var rankingArray = [Any!]()
  var textString = String()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if rankingArray.count<10 {
        for i in 0...rankingArray.count-1 {
          rankingLabel.text! += "\n第\(i+1)位　\(rankingArray[i]!)"
        }
      } else {
        for i in 0..<10 {
          rankingLabel.text! += "\n第\(i+1)位　\(rankingArray[i]!)"
        }
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  @IBAction func returnFinish(_ sender: Any) {
  }
  @IBOutlet weak var rankingLabel: UILabel!
}

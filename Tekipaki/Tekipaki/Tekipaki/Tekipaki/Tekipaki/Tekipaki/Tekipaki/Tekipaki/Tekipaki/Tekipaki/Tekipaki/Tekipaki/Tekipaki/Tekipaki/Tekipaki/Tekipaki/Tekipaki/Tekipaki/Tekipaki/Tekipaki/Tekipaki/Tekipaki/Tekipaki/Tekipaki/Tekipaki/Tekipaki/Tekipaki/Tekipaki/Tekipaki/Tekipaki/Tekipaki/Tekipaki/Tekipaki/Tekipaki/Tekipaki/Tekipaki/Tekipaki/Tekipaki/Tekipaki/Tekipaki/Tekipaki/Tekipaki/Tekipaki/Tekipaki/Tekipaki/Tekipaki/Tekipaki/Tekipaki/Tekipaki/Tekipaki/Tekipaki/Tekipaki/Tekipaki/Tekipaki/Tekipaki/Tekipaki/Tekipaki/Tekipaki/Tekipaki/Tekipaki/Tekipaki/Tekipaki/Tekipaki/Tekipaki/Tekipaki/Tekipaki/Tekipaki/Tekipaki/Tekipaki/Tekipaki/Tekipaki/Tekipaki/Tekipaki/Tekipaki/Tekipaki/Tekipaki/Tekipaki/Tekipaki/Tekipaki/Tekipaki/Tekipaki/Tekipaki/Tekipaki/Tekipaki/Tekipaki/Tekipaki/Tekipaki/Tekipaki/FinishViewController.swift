//
//  FinishViewController.swift
//  Tekipaki
//
//  Created by 海法修平 on 2017/02/14.
//  Copyright © 2017年 Swift-Beginners. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

  var message : Int!
  var lastScore : Int!
  var remainTime : Float!
  var total = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      finishLabel.text = "\(message!)問正解"
      
      total = lastScore + Int(remainTime)
      scoreLabel.text = "得点：\(lastScore!)（正解\(message!)問×20 + 不正解\(10-message!)問×(-10)）"
      
      remainTimeLabel.text = "残り時間：\(Int(remainTime))（\(remainTime!)秒）"
      
      hi_scoreLabel.text = "合計：\(total)点"//（得点\(lastScore!) + 残り時間\(Int(remainTime!))）"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      
    }
  
  func reValue () -> [Any?]{
    let ud = UserDefaults.standard
    var scoreArray = ud.array(forKey: "scoreArray")
    if scoreArray==nil {
      scoreArray = [total]
    } else {
      scoreArray?.append(total)
    }
    var AAA : [Int] = scoreArray as! [Int]
    AAA.sort(by: >)
    scoreArray = AAA
    ud.set(scoreArray, forKey: "scoreArray")
    return scoreArray!
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let controller:RankingViewController = (segue.destination as? RankingViewController)!
    controller.rankingArray = reValue()
  }

  @IBAction func toRankingButton(_ sender: Any) {
    self.performSegue(withIdentifier: "toRanking", sender: nil)
  }
  
  @IBOutlet weak var finishLabel: UILabel!

  @IBOutlet weak var hi_scoreLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var remainTimeLabel: UILabel!
}

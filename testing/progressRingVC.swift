//
//  progressRingVC.swift
//  testing
//
//  Created by admin on 4/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class progressRingVC: UIViewController {
  
  
  let percentageLabel : UILabel = {
    let label = UILabel()
    label.text = "0%"
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 30)
    return label
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let shapeLayer = CAShapeLayer()
    
    let center = view.center
    //create my track lyer
    let trackLayer = CAShapeLayer()
    let ninety = CGFloat.pi / 2
    let cicularPath = UIBezierPath.init(arcCenter: center, radius: 100, startAngle: ( -CGFloat.pi/2 ), endAngle: (2 * CGFloat.pi) - ninety , clockwise: true)
    trackLayer.path = cicularPath.cgPath
    trackLayer.strokeColor = UIColor.lightGray.cgColor
    trackLayer.lineWidth = 10
    trackLayer.fillColor = UIColor.white.cgColor
    trackLayer.lineCap = kCALineCapRound
    view.layer.addSublayer(trackLayer)
    
    
    shapeLayer.path = cicularPath.cgPath
    shapeLayer.strokeColor = #colorLiteral(red: 0.8566855788, green: 0.1049235985, blue: 0.136507839, alpha: 1)
    shapeLayer.lineWidth = 10
    shapeLayer.fillColor = UIColor.white.cgColor
    shapeLayer.lineCap = kCALineCapRound
    
    
    shapeLayer.strokeEnd = 0
    view.layer.addSublayer(shapeLayer)
    
    
    animateCircle(shapeLayer)
    
    percentageLabel.frame = CGRect(x: 0, y: 0 , width: 100, height: 100)
    percentageLabel.center = view.center
    view.addSubview(percentageLabel)
    
    //adding label
    
  }
  
  fileprivate func animateCircle(_ shapeLayer: CAShapeLayer) {
    //keypath is the thing that we want animation on
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    basicAnimation.toValue = 0.5
    basicAnimation.duration = 2
    basicAnimation.fillMode = kCAFillModeForwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "urSoBasic")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

//
//  ViewController.swift
//  testing
//
//  Created by admin on 4/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var tableDataSource = ["Row 1", "Row 2", "Row 3", "Row 4", "Row 5"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    clearBackButtonText(vc: self)
    
  }
  
  func clearBackButtonText(vc : UIViewController) {
    let backItem = UIBarButtonItem()
    backItem.title = ""
    vc.navigationItem.backBarButtonItem = backItem
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @objc func labelSwipedLeft(sender: UITapGestureRecognizer) {
    print("labelSwipedLeft called for row \(sender.view!.tag)")
  }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = tableDataSource[indexPath.row]
    cell.textLabel?.tag = indexPath.row
    //cell.textLabel?.isUserInteractionEnabled = true
    //let swipeLeft = UITapGestureRecognizer(target: self, action:#selector(self.labelSwipedLeft(sender:)))
    
    //cell.textLabel?.addGestureRecognizer(swipeLeft)
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "test", sender: self)
  }
}

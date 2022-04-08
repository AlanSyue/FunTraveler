//
//  PlanPickerViewController.swift
//  FunTraveler
//
//  Created by 林翊婷 on 2022/4/8.
//

import UIKit

class PlanPickerViewController: UIViewController {
    
    var isMovedDown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var originY:CGFloat = 0
    @IBAction func tapToClose(_ sender: UIButton) {
        
        if isMovedDown {
            UIView.transition(with: self.view, duration: 0.2, options: [.curveLinear], animations: {
                self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
            }, completion: nil)
            isMovedDown = false
            
        } else {
            UIView.transition(with: self.view, duration: 0.2, options: [.curveLinear], animations: {
                self.view.frame = CGRect(x: 0, y: 450, width: UIScreen.width, height: UIScreen.height)
            }, completion: nil)
            isMovedDown = true
        }
        
        
    }
    
}

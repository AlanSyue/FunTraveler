//
//  PlanPickerViewController.swift
//  FunTraveler
//
//  Created by 林翊婷 on 2022/4/8.
//

import UIKit

class PlanPickerViewController: UIViewController {
    
    @IBOutlet weak var zoomButton: UIButton!
    var isMoveDown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func tapZoomButton(_ sender: UIButton) {
        if isMoveDown == true {
            
            UIView.transition(with: self.view, duration: 0.2, options: [.curveLinear], animations: {
                self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
            }, completion: nil)
            zoomButton.setImage(UIImage(named: "Icons_zoomIn"), for: .selected)
            zoomButton.frame = CGRect(x: UIScreen.width - 170, y: 400, width: 50, height: 50)
            isMoveDown = false
        } else {

            UIView.transition(with: self.view, duration: 0.2, options: [.curveLinear], animations: {
                self.view.frame = CGRect(x: 0, y: 450, width: UIScreen.width, height: UIScreen.height)
            }, completion: nil)
            zoomButton.setBackgroundImage(UIImage(named: "Icons_zoomOut"), for: .selected)
            zoomButton.frame = CGRect(x: UIScreen.width - 170, y: 250, width: 50, height: 50)
            
            isMoveDown = true
        }
    }
    
}

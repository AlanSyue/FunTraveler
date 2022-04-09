//
//  ViewController.swift
//  FunTraveler
//
//  Created by 林翊婷 on 2022/4/8.
//

import UIKit

class PlanDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showPlanPicker()
    }
    
    func showPlanPicker() {
        guard let planPickerViewController = storyboard!.instantiateViewController(withIdentifier: UIStoryboard.planPickerVC) as? PlanPickerViewController else { return }
        addChild(planPickerViewController)
        planPickerViewController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
        self.view.addSubview(planPickerViewController.view)

        
//        let bottomView = UIView()
//        bottomView.frame = CGRect(x: 0, y: UIScreen.height - 80 , width: UIScreen.width, height: 80)
//        bottomView.backgroundColor = UIColor.B2
//        self.view.addSubview(bottomView)
    }


}


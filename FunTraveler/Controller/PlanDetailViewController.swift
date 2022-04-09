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
        guard let planPickerViewController = storyboard?.instantiateViewController(
            withIdentifier: UIStoryboard.planPickerVC) as? PlanPickerViewController else { return }
        addChild(planPickerViewController)
        view.addSubview(planPickerViewController.view)

        // ADD BOTTOM VIEW
        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0, y: UIScreen.height - 80, width: UIScreen.width, height: 80)
        bottomView.backgroundColor = UIColor.themeApricotDeep
        self.view.addSubview(bottomView)
    }

}

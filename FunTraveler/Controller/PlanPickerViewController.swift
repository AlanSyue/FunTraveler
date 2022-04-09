//
//  PlanPickerViewController.swift
//  FunTraveler
//
//  Created by 林翊婷 on 2022/4/8.
//

import UIKit

class PlanPickerViewController: UIViewController {
    
    let daySource = [
        DayModel(color: .red, title: "第一天"),
        DayModel(color: .yellow, title: "第二天"),
        DayModel(color: .green, title: "第三天"),
        DayModel(color: .green, title: "第四天")
    ]
    var times = ["1小時","1.5小時","2小時","2.5小時","3小時","3.5小時"]
    var planCard = ["1","2","3","4","5"] {
        didSet {
            tableView.reloadData()
            scrollToBottom()
        }
    }
    let scheduleButton = UIButton()
    
    
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            
            tableView.dataSource = self
            
            tableView.delegate = self
            
        }
    }
    
    @IBOutlet weak var zoomButton: UIButton!
    var isMoveDown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerHeaderWithNib(identifier: String(describing: PlanCardHeaderView.self), bundle: nil)

        tableView.registerCellWithNib(identifier: String(describing: PlanCardTableViewCell.self), bundle: nil)

        addScheduleButton()

    }
    
    let bottomView = UIView()

    func addScheduleButton() {
        let height: CGFloat = 80
        bottomView.frame = CGRect(x: 0, y: UIScreen.height - height , width: UIScreen.width, height: height)
        bottomView.backgroundColor = UIColor.B2
        self.view.addSubview(bottomView)
        
        scheduleButton.backgroundColor = UIColor.ThemeRed
        scheduleButton.setTitle("+", for: .normal)
        scheduleButton.addTarget(target, action: #selector(tapScheduleButton), for: .touchUpInside)
        bottomView.addSubview(scheduleButton)
        layoutOfScheduleButton()
    }
    
    func layoutOfScheduleButton() {
        scheduleButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0).isActive = true
        
        scheduleButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor,constant: 0).isActive = true
        scheduleButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 2/3 ).isActive = true
        scheduleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func tapScheduleButton() {
        planCard.append("new")
        tableView.reloadData()
        
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
                self.view.frame = CGRect(x: 0, y: 550, width: UIScreen.width, height: UIScreen.height)
            }, completion: nil)
            zoomButton.setBackgroundImage(UIImage(named: "Icons_zoomOut"), for: .selected)
            zoomButton.frame = CGRect(x: UIScreen.width - 170, y: 250, width: 50, height: 50)
            
            isMoveDown = true
        }
    }
    
}


extension PlanPickerViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Section Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: PlanCardHeaderView.identifier)
        as? PlanCardHeaderView else { return nil }
        
        headerView.titleLabel.text = "小琉球潛水之旅"
        headerView.dateLabel.text = "2022年10月06日- 2022年10月08日"
        
        headerView.selectionView.delegate = self
        headerView.selectionView.dataSource = self
        
        return headerView
    }
    
    // MARK: - Section Row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "\(PlanCardTableViewCell.self)", for: indexPath) as? PlanCardTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.nameLabel.text = "景福宮"
        cell.addressLabel.text = "保安三街8-1號"
        cell.layoutCell(startTime: "09:30")
        
        return cell
    }

    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.planCard.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

}

extension PlanPickerViewController: PlanCardTableViewCellDelegate {
    
    func endEditing(_ cell: PlanCardTableViewCell) {
        
        tableView.reloadData()
    }
    
}



extension PlanPickerViewController: SelectionViewDataSource {
    
    func configureNumberOfButton(_ selectionView: SelectionView) -> Int {
        
        return daySource.count
    }
    
    func configureDetailOfButton(_ selectionView: SelectionView) -> [DayModel] {
        return daySource

    }
    
    func colorOfindicator() -> UIColor {
        .black
    }
    
    func colorOfText() -> UIColor {
        .black
    }
    
}

@objc extension PlanPickerViewController: SelectionViewDelegate {
    @objc func didSelectedButton(_ selectionView: SelectionView, at index: Int){
        //tableView.backgroundColor = daySource[index].color
    }
    
    @objc func shouldSelectedButton(_ selectionView: SelectionView, at index: Int) -> Bool {
            return true
    }
}



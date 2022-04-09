//
//  PlanCardTableViewCell.swift
//  PlanningCardTest
//
//  Created by 林翊婷 on 2022/4/6.
//

import UIKit

protocol PlanCardTableViewCellDelegate: AnyObject {
    func endEditing(_ cell: PlanCardTableViewCell)
}

class PlanCardTableViewCell: UITableViewCell {

    weak var delegate: PlanCardTableViewCellDelegate?

    var durationTime: String?

    var times = ["1", "1.5", "2", "2.5", "3", "3.5"]

    @IBOutlet weak var pickerView: TimePickerView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    
    @IBOutlet weak var orderLabel: UIImageView!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.pickerView.delegate = self
        pickerView.pickerView.dataSource = self

        self.pickerView.timeTextField.text = "1小時"
    }
    
    func layoutCell(
        startTime: String
    ) {
        
        startTimeLabel.text = startTime
        
        do {
            let date = try TimeManager.getDateFromString(
                dateFormat: "HH:mm", dateString: startTime, duration:
                    Double(pickerView.timeTextField.text ?? "2.00") ?? 2.00)
            
            endTimeLabel.text = "\(date.endHours):\(date.endMinutes)"

        } catch let wrongError {
            print("Error message: \(wrongError),Please add correct time!")
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // print("Hello")
        self.pickerView.timeTextField.addTarget(self, action: #selector(tapToChangeDate), for: .valueChanged)
    }
    
    @objc func tapToChangeDate(datePicker: UIDatePicker) {
        
        print("datePicker", datePicker)
    }
    
}

extension PlanCardTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(times[row])小時"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.pickerView.timeTextField.text = "\(times[row])小時"
        
    }
}


extension PlanCardTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        delegate?.endEditing(self)
    }
}

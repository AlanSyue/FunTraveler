//
//  SelectionView.swift
//  DI-Part-1---Delegate_Sally
//
//  Created by 林翊婷 on 2022/3/28.
//

import UIKit

struct DayModel {
    let color: UIColor
    let title: String
}


protocol SelectionViewDataSource: AnyObject {
    func configureNumberOfButton(_ selectionView: SelectionView) -> Int
    
    func configureDetailOfButton(_ selectionView: SelectionView) -> [DayModel]
    
    func colorOfindicator() -> UIColor
    
    func colorOfText() -> UIColor
    
}

@objc protocol SelectionViewDelegate: AnyObject {
    
    @objc optional func didSelectedButton(_ selectionView: SelectionView, at index: Int)
    
    @objc optional func shouldSelectedButton(_ selectionView: SelectionView, at index: Int) -> Bool
}




class SelectionView: UIView {
    
    let indicatorView = UIView()
    let button = UIButton()
    
    weak var dataSource: SelectionViewDataSource?
    weak var delegate: SelectionViewDelegate?
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureButton()
    }
    
    
    func configureButton(){
        guard let numberOfButton = dataSource?.configureNumberOfButton(self) else { return }

        //let numberOfButton = dataSource?.configureNumberOfButton(self) ?? 2 //?
        
        for i in 0...numberOfButton - 1 {
            // SET BUTTON POSITION
            let colorButton = UIButton()
            
            let width = UIScreen.main.bounds.width/CGFloat(numberOfButton) * 5/6
            colorButton.frame = CGRect(x: CGFloat(i)*(width), y: 0, width: width, height: 50)
            
            colorButton.backgroundColor = .white
            
            // SET BUTTON TITLE
            let titleOfButton = dataSource?.configureDetailOfButton(self)
            
            colorButton.setTitle("\(titleOfButton?[i].title ?? "")", for: .normal)
            
            // SET BUTTON TITLE COLOR & FONT
            let colorOfText = dataSource?.colorOfText() ?? .black
            
            colorButton.setTitleColor(colorOfText, for: .normal)
            
            colorButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            
            colorButton.addTarget(self, action: #selector(tapColorButton), for: .touchUpInside)
            
            self.addSubview(colorButton)
            
            // SET INDICATOR
            indicatorView.frame = CGRect(x: 0, y: 45, width: width, height: 3)

            let colorOfindicator = dataSource?.colorOfindicator() ?? .blue
            
            indicatorView.backgroundColor = colorOfindicator
            
            self.addSubview(indicatorView)
            
        }
        
    }
    
    @objc func tapColorButton(_ sender: UIButton){
        
        guard let numberOfButton = dataSource?.configureNumberOfButton(self) else { return }

        let width = UIScreen.main.bounds.width/CGFloat(numberOfButton)
        let index = Int(sender.frame.origin.x / width)
        
        if delegate?.shouldSelectedButton?(self, at: index) == false {
            return
        }
        delegate?.didSelectedButton?(self, at: index)
        
        UIView.transition(with: self, duration: 0.3, options: [.curveEaseOut], animations: {
            self.indicatorView.frame = CGRect(x: sender.frame.minX, y: 45, width: width * 5/6, height: 3)

        })
    }
   
}
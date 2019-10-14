//
//  ReminderPopupView.swift
//  RemindersApp
//
//  Created by Jacob Rozell on 10/14/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import Foundation
import UIKit


class ReminderPopup: UIViewController {
    
    let titleLabel = UILabel()
    let separatorView = UIView()
    let dateTimeLabel = UILabel()
    let dateTimePicket = UIDatePicker()
    let remimdMeLabel = UILabel()
    let remindMePicker = UIPickerView()
    let descLabel = UILabel()
    let descTextField = UITextField()
    
    let stackView = UIStackView()
    let createButton = UIButton()
    let cancelButton = UIButton()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        titleLabel.text = "Title"
        titleLabel.isUserInteractionEnabled = true
        
        separatorView.backgroundColor = UIStyle.LightMode.black.toColor()
        
    }
    
    func setupConstraints() {
        
    }
}

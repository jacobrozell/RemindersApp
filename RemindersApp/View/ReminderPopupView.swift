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
    
   // var choices: [RemindMe: String] = [RemindMe: String]()
    
    var choices = [String]()
    var choicesAsEnum = [RemindMe]()
    
    var itemToAdd = ReminderItem(title: "", reminderDate: "", whenToRemind: RemindMe.then, description: "")
    let selectedRemindMeTime: RemindMe = RemindMe.then
    
    let titleLabel = UITextField()
    let separatorView = UIView()
    let dateTimeLabel = UILabel()
    let dateTimePicker = UIDatePicker()
    let remindMeLabel = UILabel()
    let remindMePicker = UIPickerView()
    let descLabel = UILabel()
    let descTextField = UITextField()
    
    let stackView = UIStackView()
    let createButton = UIButton()
    let cancelButton = UIButton()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        title = "Add New Reminder"
        
        self.view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupChoices()
        setupViews()
        setupConstraints()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setupChoices() {
        for value in RemindMe.allCases {
            choices.append(value.rawValue)
            choicesAsEnum.append(value)
        }
    }
    
    func setupViews() {
        titleLabel.placeholder = "Title"
        titleLabel.isUserInteractionEnabled = true
        titleLabel.textColor = UIStyle.LightMode.black.toColor()
        
        dateTimeLabel.text = "Date/Time"
        dateTimeLabel.textAlignment = .left
        dateTimeLabel.textColor = UIStyle.LightMode.black.toColor()
        
        dateTimePicker.date = Date()
        dateTimePicker.minimumDate = Date()
        dateTimePicker.maximumDate = Date.distantFuture
        dateTimePicker.datePickerMode = .dateAndTime
        //dateTimePicker.backgroundColor = UIColor(hex: "#123456", andAlpha: 1.0)
        
        remindMeLabel.text = "Remind me:"
        remindMeLabel.textAlignment = .left
        remindMeLabel.textColor = UIStyle.LightMode.black.toColor()
        
        remindMePicker.dataSource = self
        remindMePicker.delegate = self
        //remindMePicker.backgroundColor = UIColor(hex: "#123456", andAlpha: 1.0)
        
        descLabel.text = "Description:"
        descLabel.textAlignment = .left
        descLabel.textColor = UIStyle.LightMode.black.toColor()
        
        descTextField.placeholder = "Additonal Information"
        //descTextField.backgroundColor = UIColor(hex: "#123456", andAlpha: 1.0)
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(UIColor(hex: "#123456", andAlpha: 1.0), for: .normal)
        createButton.addTarget(self, action: #selector(createPressed), for: .touchUpInside)
        
        stackView.addArrangedSubview(createButton)
        stackView.addArrangedSubview(cancelButton)
        
        self.view.addSubviews(titleLabel, separatorView, dateTimeLabel, dateTimePicker, remindMeLabel, remindMePicker, descLabel, descTextField, createButton)

    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(90)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
        
//        separatorView.snp.makeConstraints { (make) in
//            make.height.equalTo(2)
//            make.left.right.equalToSuperview().inset(8)
//            make.top.equalTo(titleLabel.snp.bottom).offset(8)
//        }
        
        dateTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }
        
        dateTimePicker.snp.makeConstraints { (make) in
            make.top.equalTo(dateTimeLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(80)
        }
        
        remindMeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateTimePicker.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }
        
        remindMePicker.snp.makeConstraints { (make) in
            make.top.equalTo(remindMeLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(80)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(remindMePicker.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }
        
        descTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(120)
        }
        
        createButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-4)
            make.left.right.equalToSuperview().inset(4)
            make.height.equalTo(150)
        }
    }
    
    @objc func createPressed() {
        print("Create button pressed")
        
//        let item = ReminderItem(title: titleLabel.text!, reminderDate: dateTimePicker.date.string(with: "MMM dd, yyyy"), whenToRemind: choicesAsEnum[remindMePicker.selectedRow(inComponent: 1)], description: descTextField.text!)
//        
//        self.itemToAdd = item
        self.dismiss(animated: true, completion: nil)

    }
    
}

// MARK: - UIPickerViewDelegate/UIPickerViewDataSource
extension ReminderPopup: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row) index selected! -> \(choices[row])")
        
    }
}

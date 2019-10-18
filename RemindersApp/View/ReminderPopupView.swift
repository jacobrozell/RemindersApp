//
//  ReminderPopupView.swift
//  RemindersApp
//
//  Created by Jacob Rozell on 10/14/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD
import CoreData

// MARK: - UIProtocol
protocol ReminderPopupUI {
    func setupColors()
    func setupViews()
    func setupConstraints()
}

// MARK: - ReminderPopupViewController
class ReminderPopup: UIViewController {
    
   // var choices: [RemindMe: String] = [RemindMe: String]()
    
    var choices = [String]()
    var choicesAsEnum = [RemindMe]()
    
    var itemToAdd = ReminderItem()
    
    let titleCard = UIView()
    let titleTextField = UITextField()
    let separatorView = UIView()
    
    let dateTimeCardView = UIView()
    let dateTimeLabel = UILabel()
    let dateTimePicker = UIDatePicker()
    
    let remindMeCard = UIView()
    let remindMeLabel = UILabel()
    let remindMePicker = UIPickerView()
    
    let descCard = UIView()
    let descLabel = UILabel()
    let descTextField = UITextView()
    
    let createButton = UIButton()
    
    var selectedReminderTime: RemindMe = .then
    
    var parentVC = RemindersViewController()
    
    convenience init(parentVC: RemindersViewController) {
        self.init(nibName: nil, bundle: nil)
        
        self.parentVC = parentVC
        
        title = "Add New Reminder"
        
        self.edgesForExtendedLayout = []
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupChoices()
        setupColors()
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
    
    @objc func createPressed() {
        print("Create button pressed")
        print("titleTextField: \(titleTextField.text!)\nreminderDate: \(dateTimePicker.date)\nwhenToRemind: \(selectedReminderTime.rawValue)\ndesc: \(descTextField.text!)")
        
        guard let title = titleTextField.text else { return }
        
        parentVC.createItem(title: title, reminderTime: selectedReminderTime.rawValue, eventTime: dateTimePicker.date.string(with: UIStyle.format), note: descTextField.text ?? "")

        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - ReminderUI Extension
extension ReminderPopup: ReminderPopupUI {
    func setupColors() {
        view.backgroundColor = UIStyle.cellSpaceBackgroundColor
        
        titleCard.backgroundColor = UIStyle.cellBackgroundColor
        
        titleTextField.tintColor = UIStyle.titleTextColor
        titleTextField.textColor = UIStyle.titleTextColor
        titleTextField.backgroundColor = UIStyle.cellBackgroundColor
        
        separatorView.backgroundColor = UIStyle.separatorColor
        
        dateTimeCardView.backgroundColor = UIStyle.cellBackgroundColor
        
        dateTimeLabel.tintColor = UIStyle.cellTextColor
        dateTimeLabel.textColor = UIStyle.cellTextColor

        
        dateTimePicker.setValue(UIStyle.cellTextColor, forKeyPath: "textColor")
        dateTimePicker.setValue(false, forKey: "highlightsToday")
        
        remindMeCard.backgroundColor = UIStyle.cellBackgroundColor
        remindMeLabel.textColor = UIStyle.cellTextColor
        remindMeLabel.tintColor = UIStyle.cellTextColor
        
        descCard.backgroundColor = UIStyle.cellBackgroundColor
        descLabel.textColor = UIStyle.cellTextColor
        descTextField.backgroundColor = UIStyle.cellBackgroundColor
        descTextField.tintColor = UIStyle.cellTextColor
        
        createButton.backgroundColor = UIStyle.cellBackgroundColor
        createButton.setTitleColor(UIStyle.cellTextColor, for: .normal)
    }
    
    func setupViews() {
        
        titleCard.layer.cornerRadius = 8.0
        titleCard.clipsToBounds = true
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: UIStyle.separatorColor])
        titleTextField.isUserInteractionEnabled = true
        titleTextField.font = UIFont.systemFont(ofSize: 20.0)
    
        dateTimeCardView.layer.cornerRadius = 12.0
        dateTimeCardView.clipsToBounds = true
        
        dateTimeLabel.text = "Event Date/Time:"
        dateTimeLabel.textAlignment = .left
        
        dateTimePicker.date = Date()
        dateTimePicker.minimumDate = Date()
        dateTimePicker.maximumDate = Date.distantFuture
        dateTimePicker.datePickerMode = .dateAndTime
        
        remindMeCard.layer.cornerRadius = 12.0
        remindMeCard.clipsToBounds = true
        
        remindMeLabel.text = "Remind me:"
        remindMeLabel.textAlignment = .left
        
        remindMePicker.dataSource = self
        remindMePicker.delegate = self
        
        descCard.layer.cornerRadius = 12.0
        descCard.clipsToBounds = true
        
        descLabel.text = "Note:"
        descLabel.textAlignment = .left
        
        descTextField.textAlignment = .justified
        descTextField.layer.cornerRadius = 5.0
        descTextField.clipsToBounds = true
        descTextField.attributedText = NSAttributedString(string: "Note", attributes: [NSAttributedString.Key.foregroundColor: UIStyle.separatorColor])
        descTextField.textColor = UIStyle.titleTextColor
        
        createButton.setTitle("Create", for: .normal)
        createButton.addTarget(self, action: #selector(createPressed), for: .touchUpInside)
        createButton.layer.cornerRadius = 12.0
        createButton.clipsToBounds = true
        setupDropShadows()
        
        self.view.addSubviews(titleCard, dateTimeCardView, remindMeCard, descCard, createButton)
        
        titleCard.addSubviews(titleTextField, separatorView)
        dateTimeCardView.addSubviews(dateTimeLabel, dateTimePicker)
        remindMeCard.addSubviews(remindMeLabel, remindMePicker)
        descCard.addSubviews(descLabel, descTextField)
    }
    
    func setupDropShadows() {
        titleCard.addDropShadow()
        dateTimeCardView.addDropShadow()
        remindMeCard.addDropShadow()
        descCard.addDropShadow()
    }
    
    func setupConstraints() {
        titleCard.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(42)
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(26)
        }
        
        //separatorView.snp.makeConstraints { (make) in
         //   make.height.equalTo(1)
///make.left.right.equalToSuperview().inset(8)
         //   make.top.equalTo(titleTextField.snp.bottom).offset(5)
        //}
        
        dateTimeCardView.snp.makeConstraints { (make) in
            make.top.equalTo(titleCard.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        dateTimeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(15)
        }
        
        dateTimePicker.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-4)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        remindMeCard.snp.makeConstraints { (make) in
            make.top.equalTo(dateTimeCardView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        remindMeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(15)
        }
        
        remindMePicker.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-4)
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(80)
        }
        
        descCard.snp.makeConstraints { (make) in
            make.top.equalTo(remindMeCard.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(15)
        }
        
        descTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        createButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
}

// MARK: - UIPickerViewDelegate/UIPickerViewDataSource Extension
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
        selectedReminderTime = choicesAsEnum[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: choices[row], attributes: [NSAttributedString.Key.foregroundColor: UIStyle.cellTextColor])
    }
}

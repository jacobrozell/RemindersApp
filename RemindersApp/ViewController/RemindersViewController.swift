//
//  RemindersTableView.swift
//  FeatureTesting2.0
//
//  Created by Jacob Rozell on 10/14/19.
//

import Foundation
import SnapKit
import UIKit
import STPopup

class RemindersViewController: UIViewController {

    let tableView = UITableView()
    var reminders: [ReminderItem] = []

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reminders"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminder)), animated: true)

        view.addSubview(tableView)
        setupTableView()
        
        reminders.append(ReminderItem(title: "Doctors Appointment", reminderDate: "8/12/99", whenToRemind: RemindMe.then, description: "Make sure to ask him about your severe depression!"))
        reminders.append(ReminderItem(title: "Prostate Exam", reminderDate: "8/22/19", whenToRemind: RemindMe.then, description: "It's gonna suck!"))
    }

    func setupTableView() {
        tableView.register(RemindersCardCell.self, forCellReuseIdentifier: RemindersCardCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIStyle.backgroundColor
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        
        let footerView = UIView()
        footerView.backgroundColor = UIStyle.backgroundColor
        tableView.tableFooterView = footerView
        
        tableView.snp.makeConstraints { (make) in
            make.height.width.equalToSuperview()
        }
    }
    
    func append(_ item: ReminderItem) {
        reminders.append(item)
        tableView.reloadData()
    }
    
    @objc func addReminder() {
        self.navigationController?.pushViewController(ReminderPopup(parentVC: self), animated: true)
    }
}

extension RemindersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = reminders[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RemindersCardCell.reuseID, for: indexPath) as? RemindersCardCell else { return UITableViewCell() }
        
        cell.setupCell(title: item.title, date: item.reminderDate, desc: item.description)
        return cell
    }
}

extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

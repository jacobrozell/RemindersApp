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

    let format = "MMM dd, yyyy"
    
    let tableView = UITableView()
    var reminders: [ReminderItem] = []
    

    lazy var textSize: Int = UserDefaults.standard.object(forKey: "savedFontSize") as? Int ?? 18

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
        setConstraints()
        tableView.register(RemindersCardCell.self, forCellReuseIdentifier: RemindersCardCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(hex: "#EEEEEE", andAlpha: 1.0)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.tableFooterView = UIView()
        
        reminders.append(ReminderItem(title: "Test!", reminderDate: "DEEZ NUTZZZZZ", whenToRemind: RemindMe.then, description: "sdfsdfsdfsdfsdfbghjsdfhbsdfhdsf hksffhkbdsfhdfhd hhhh hhh hh hb hbh bhb ghb hbc bdcvhji bdvihj bdvj bdcvj bndfvju bndfovu bndfiouv ibndoufvbn odufvbnodufvbn dioufv bdiufbv idufbv diufb "))
        
        reminders.append(ReminderItem(title: "Test2", reminderDate: "Here is another DEEZ NUTZ", whenToRemind: RemindMe.then, description: "sdfsdfsdfsdfsdfbghjsdfhbsdfhdsf hksffhkbdsfhdfhd hhhh hhh hh hb hbh bhb ghb hbc bdcvhji bdvihj bdvj bdcvj bndfvju bndfovu bndfiouv ibndoufvbn odufvbnodufvbn dioufv bdiufbv idufbv diufb "))
    }

    func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.height.width.equalToSuperview()
        }
    }
    
    @objc func addReminder() {
        
        let popup = ReminderPopup()
        
        self.navigationController?.pushViewController(popup, animated: true)
        
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

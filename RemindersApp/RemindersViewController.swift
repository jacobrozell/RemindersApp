//
//  RemindersTableView.swift
//  FeatureTesting2.0
//
//  Created by Jacob Rozell on 10/14/19.
//

import Foundation
import SnapKit
import UIKit

class RemindersViewController: UIViewController {
    static let version = "1.1"

    let tableView = UITableView()
    var tableViewData: [ReminderItem] = []
    

    lazy var textSize: Int = UserDefaults.standard.object(forKey: "savedFontSize") as? Int ?? 18

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        tableViewData.append(ReminderItem(title: "Test!", reminderDate: "DEEZ NUTZZZZZ", description: "sdfsdfsdfsdfsdfbghjsdfhbsdfhdsf hksffhkbdsfhdfhd hhhh hhh hh hb hbh bhb ghb hbc bdcvhji bdvihj bdvj bdcvj bndfvju bndfovu bndfiouv ibndoufvbn odufvbnodufvbn dioufv bdiufbv idufbv diufb "))
        
        tableViewData.append(ReminderItem(title: "Test2", reminderDate: "Here is another DEEZ NUTZ", description: "sdfsdfsdfsdfsdfbghjsdfhbsdfhdsf hksffhkbdsfhdfhd hhhh hhh hh hb hbh bhb ghb hbc bdcvhji bdvihj bdvj bdcvj bndfvju bndfovu bndfiouv ibndoufvbn odufvbnodufvbn dioufv bdiufbv idufbv diufb "))
    }

    func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.height.width.equalToSuperview()
        }
    }
}

extension RemindersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableViewData[indexPath.row]
        
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

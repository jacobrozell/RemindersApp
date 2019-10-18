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
import CoreData

// MARK: - CoreDataManupulation Protocol
protocol CoreDataManupulation {
    func createItem(title: String, reminderTime: String, eventTime: String, note: String) -> ReminderItem
    func saveItems()
    func loadItems(_ request: NSFetchRequest<ReminderItem>)
    func deleteItem(at indexPath: IndexPath)
}

// MARK: - RemindersViewController
class RemindersViewController: UIViewController {
    let tableView = UITableView()
    var reminders: [ReminderItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        title = "Reminders"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminder)), animated: true)

        view.addSubview(tableView)
        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveItems()
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
        saveItems()
    }
    
    @objc func addReminder() {
        self.navigationController?.pushViewController(ReminderPopup(parentVC: self), animated: true)
    }
}

// MARK: - CoreDataManupulation Extension
extension RemindersViewController: CoreDataManupulation {
    func createItem(title: String, reminderTime: String, eventTime: String, note: String) -> ReminderItem {
        let newItem = ReminderItem(context: context)
        
        newItem.title = title
        newItem.reminderTime = reminderTime
        newItem.eventTime = eventTime
        newItem.note = note
        
        append(newItem)
        return newItem
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("error saving context \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    func loadItems(_ request: NSFetchRequest<ReminderItem>=ReminderItem.fetchRequest()) {
        do {
            reminders = try context.fetch(request)
        } catch {
            print("error fetching data from context \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    func deleteItem(at indexPath: IndexPath) {
        context.delete(reminders[indexPath.row])
        reminders.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        saveItems()
    }
}

// MARK: - UITableViewDataSource Extension
extension RemindersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = reminders[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RemindersCardCell.reuseID, for: indexPath) as? RemindersCardCell else { return UITableViewCell() }
        
        guard let title = item.title, let reminderDate = item.reminderTime, let eventDate = item.eventTime else { return UITableViewCell() }
        cell.setupCell(title: title, reminderDate: reminderDate, eventDate: eventDate, note: item.note)
        return cell
    }
}

// MARK: - UITableViewDelegate Extension
extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, sucess) in
            self.deleteItem(at: indexPath)
            sucess(true)
        }

        deleteAction.image = UIImage(named: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

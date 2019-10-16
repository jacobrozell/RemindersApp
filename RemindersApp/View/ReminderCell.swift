//
//  ReminderCell.swift
//  FeatureTesting2.0
//
//  Created by Jacob Rozell on 10/14/19.
//

import UIKit
import SnapKit

class RemindersCardCell: UITableViewCell {
    static let reuseID = "RemindersCardCell"
    
    let cellBackgroundView = UIView()
    let statusView = UIView()
    let cardView = UIView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let descLabel = UILabel()
    // let showInCalendarButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        statusView.layer.cornerRadius = 6.0
        statusView.clipsToBounds = true
    
        cardView.layer.cornerRadius = 16.0
        cardView.clipsToBounds = true
        cardView.layer.masksToBounds = false
        cardView.addDropShadow()
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        descLabel.numberOfLines = 2
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byTruncatingTail

        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubviews(statusView, cardView)
        cardView.addSubviews(titleLabel, dateLabel, descLabel)//, showInCalendarButton)
    }
    
    func setupColors() {
        cellBackgroundView.backgroundColor = UIStyle.cellSpaceBackgroundColor
        statusView.backgroundColor = UIStyle.cellTextColor
        cardView.backgroundColor = UIStyle.cellBackgroundColor
        titleLabel.textColor = UIStyle.cellTextColor
        //showInCalendarButton.backgroundColor = defaultColor
        dateLabel.textColor = UIStyle.cellTextColor
        descLabel.textColor = UIStyle.cellTextColor
    }
    
    func setupCell(title: String, reminderDate: String, eventDate: String, note: String?="") {
        titleLabel.text = title
        dateLabel.text = eventDate
        descLabel.text = note
        
        setupColors()
        setupConstraints()
        
        #warning("not doing anything with reminderDate yet")
    }

    func setupConstraints() {
        cellBackgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
//        statusView.snp.makeConstraints { (make) in
//            make.width.height.equalTo(10)
//            make.left.equalToSuperview().offset(8)
//            make.right.equalTo(cardView.snp.left).offset(-8)
//
//            make.centerY.equalToSuperview()
//        }
        
        cardView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            if descLabel.text == "" {
                make.centerY.equalToSuperview()
            } else {
                make.top.equalToSuperview().offset(4)
            }
            make.left.equalToSuperview().offset(4)
            make.right.equalTo(cardView.snp.centerX).offset(-4)//(showInCalendarButton.snp.left).offset(-4)
            make.height.equalTo(30)
        }
        
//        showInCalendarButton.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(4)
//            make.right.equalToSuperview().offset(-4)
//            make.width.equalTo(20)
//            make.height.equalTo(20)
//        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(30)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-6)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        dateLabel.text = nil
        descLabel.text = nil
    }
}

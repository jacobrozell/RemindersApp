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
    
    let defaultColor = UIColor(hex: "#0000FF", andAlpha: 1.0)
    
    let cellBackgroundView = UIView()
    let statusView = UIView()
    let cardView = UIView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let descLabel = UILabel()
    let showInCalendarButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        statusView.backgroundColor = defaultColor
    
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8.0
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowColor = UIColor(hex: "#121212", andAlpha: 1.0).cgColor
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.2
        cardView.clipsToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        descLabel.numberOfLines = 4
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byTruncatingTail

        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubviews(statusView, cardView)
        cardView.addSubviews(titleLabel, dateLabel, descLabel, showInCalendarButton)
        
        setupConstraints()
    }
    
    func setupCell(title: String, date: String, desc: String) {
        titleLabel.text = title
        dateLabel.text = date
        descLabel.text = desc
    }

    func setupConstraints() {
        cellBackgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        statusView.snp.makeConstraints { (make) in
            make.width.equalTo(15)
            make.top.bottom.left.equalToSuperview()
        }
        
        cardView.snp.makeConstraints { (make) in
            make.left.equalTo(statusView.snp.right).offset(8)
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(4)
            make.right.equalTo(showInCalendarButton.snp.left).offset(-4)
            make.height.equalTo(30)
        }
        
        showInCalendarButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.left.equalTo(dateLabel.snp.left)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
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

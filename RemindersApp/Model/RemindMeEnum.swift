//
//  ReminderItem.swift
//  FeatureTesting2.0
//
//  Created by Jacob Rozell on 10/14/19.
//

import Foundation

enum RemindMe: String, CaseIterable {
    case oneDay = "1 Day Before"
    case twelveHours = "12 Hours Before"
    case oneHour = "1 Hour Before"
    case thirtyMin = "30 Minutes Before"
    case fifteenMin = "15 Minutes Before"
    case tenMin = "10 Minutes Before"
    case fiveMin = "5 Minutes Before"
    case oneMin = "1 Minute Before"
    case thirtySec = "30 Seconds Before"
    case then = "When it is the given time"


    static let allValues = [oneDay, twelveHours, oneHour, thirtyMin, fifteenMin, tenMin, fiveMin, oneMin, thirtySec, then]

    func allItems() -> [String] {
        var items = [String]()

        for value in RemindMe.allValues {
            items.append(value.rawValue)
        }
        return items
    }
}

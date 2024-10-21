//
//  Date+Extension.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 21.10.2024.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Europe/Istanbul")

        return formatter
    }

    var monthDayYearString: String {
        let dateFormatter = Self.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"

        return dateFormatter.string(from: self)
    }
}

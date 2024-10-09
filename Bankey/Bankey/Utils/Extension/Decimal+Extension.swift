//
//  Decimal+Extension.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 9.10.2024.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}

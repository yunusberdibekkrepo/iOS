//
//  LocalState.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 9.09.2024.
//

import Foundation

final class LocalState {
    private enum Keys: String {
        case hasOnboarded
    }

    static var hasOnboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }

        set(newValue) {
            UserDefaults.standard.setValue(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
}

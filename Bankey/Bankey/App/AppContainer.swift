//
//  AppContainer.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 6.09.2024.
//

import Foundation

let appContainer: AppContainer = .init(router: AppRouter())

final class AppContainer {
    let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }
}

//
//  AppDelegate.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 6.09.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appContainer.router.rootViewController = LoginViewController()
        appContainer.router.didFinishLaunchingWithOptions()
        return true
    }
}

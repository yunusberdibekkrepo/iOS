//
//  AppRouter.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 6.09.2024.
//

import UIKit

final class AppRouter {
    var rootViewController: UIViewController?
    var window: UIWindow?

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.systemBackground
    }

    func didFinishLaunchingWithOptions() {
        self.window?.rootViewController = rootViewController ?? OnboardingViewController()
        self.window?.makeKeyAndVisible()
    }
}

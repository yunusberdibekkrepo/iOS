//
//  AppRouter.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 6.09.2024.
//

import UIKit

final class AppRouter {
    var window: UIWindow

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.backgroundColor = UIColor.systemBackground
    }

    func didFinishLaunchingWithOptions() {
        hasOnboarded()

        self.window.makeKeyAndVisible()
    }
}

// MARK: - Private Methods

private extension AppRouter {
    func hasOnboarded() {
        let hasOnboarded = UserDefaults.standard.bool(forKey: "hasOnboarded")

        if hasOnboarded {
            changeRootViewController(with: LoginViewController())
        } else {
            changeRootViewController(with: OnboardingViewController())
        }
    }
}

// MARK: - Public Methods

extension AppRouter {
    func changeRootViewController(with rootViewController: UIViewController) {
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromRight],
                          animations: {
                              self.window.rootViewController = UINavigationController(rootViewController: rootViewController)
                          },
                          completion: nil)
    }
}

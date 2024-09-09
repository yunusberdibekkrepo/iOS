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
    }
}

// MARK: - Private Methods

private extension AppRouter {
    func hasOnboarded() {
        if LocalState.hasOnboarded {
            changeRootViewController(with: LoginViewController())
        } else {
            changeRootViewController(with: OnboardingViewController())
        }
    }
}

// MARK: - Public Methods

extension AppRouter {
    func changeRootViewController(with rootViewController: UIViewController, animated: Bool = true) {
        guard animated else {
            self.window.rootViewController = rootViewController
            self.window.makeKeyAndVisible()

            return
        }

        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        window.makeKeyAndVisible()

        UIView.transition(with: window,
                          duration: 0.4,
                          options: [.transitionFlipFromRight],
                          animations: nil,
                          completion: nil)
    }
}

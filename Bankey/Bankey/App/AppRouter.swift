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
        window.backgroundColor = UIColor.systemBackground

        registerForNotifications()
    }

    func didFinishLaunchingWithOptions() {
        hasOnboarded()
    }
}

// MARK: - Private Methods

private extension AppRouter {
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(hasLogout), name: .logout, object: nil)
    }

    func hasOnboarded() {
        if LocalState.hasOnboarded {
            let controller = LoginViewController()

            changeRootViewController(with: controller, animated: false)
        } else {
            changeRootViewController(with: OnboardingViewController())
        }
    }

    @objc
    func hasLogout() {
        let controller = LoginViewController()

        changeRootViewController(with: controller, animated: true)
    }
}

// MARK: - Public Methods

extension AppRouter {
    func changeRootViewController(with rootViewController: UIViewController, animated: Bool = true) {
        guard animated else {
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()

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

//
//  MainViewController.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 5.10.2024.
//

import UIKit

final class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupControllers()
    }

    private func setupView() {
        tabBar.tintColor = appContainer.theme.appColor
        tabBar.isTranslucent = false
    }

    private func setupControllers() {
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()

        summaryVC.setTabBarImage(systemName: "list.dash.header.rectangle",
                                 title: "Summary", tag: 0)

        moneyVC.setTabBarImage(systemName: "arrow.left.arrow.right",
                               title: "Move Money", tag: 1)

        moreVC.setTabBarImage(systemName: "ellipsis.circle",
                              title: "More", tag: 2)

        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)

        summaryNC.navigationBar.barTintColor = appContainer.theme.appColor

        let tabBarList = [summaryNC, moneyNC, moreNC]
        viewControllers = tabBarList
    }

    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img // We are hiding one pixel line appears under the bar.
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}

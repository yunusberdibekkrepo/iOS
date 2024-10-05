//
//  UIViewController+Extension.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 5.10.2024.
//

import UIKit

extension UIViewController {
    func setStatusBar() {
        guard let statusBarSize = appContainer.router.window.windowScene?.statusBarManager?.statusBarFrame.size else {
            print("Null status bar size")
            return
        }

        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusBarView = UIView(frame: frame)

        statusBarView.backgroundColor = appContainer.theme.appColor
        view.addSubview(statusBarView)
    }

    func setTabBarImage(systemName: String, title: String, tag: Int) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: systemName, withConfiguration: configuration)

        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
}

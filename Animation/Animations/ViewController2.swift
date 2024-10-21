//
//  ViewController2.swift
//  Animations
//
//  Created by Yunus Emre Berdibek on 21.10.2024.
//

import UIKit

final class ViewController2: UIViewController {
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .magenta
        button.configuration?.baseForegroundColor = .white
        button.configuration?.title = "Animate"
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }

    func setup() {
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 10),
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 2),
            button.heightAnchor.constraint(equalToConstant: 75)
        ])
    }

    @objc func animate() {
        shakeAnimation()
    }

    func shakeAnimation() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x" // position.y
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 3

        animation.isAdditive = true
        button.layer.add(animation, forKey: "shake")
    }
}

#Preview {
    ViewController2()
}

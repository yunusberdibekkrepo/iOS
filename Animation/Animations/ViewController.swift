//
//  ViewController.swift
//  Animations
//
//  Created by Yunus Emre Berdibek on 20.10.2024.
//

import UIKit

/*
 UIView.animate ile UIViewPropertyAnimator arasındaki temel fark UIViewPropertyAnimator'de kullanılan olan animasyon tipi'nin belirlenmesi.
 */

final class ViewController: UIViewController {
    lazy var button: UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .magenta
        button.configuration?.baseForegroundColor = .white
        button.configuration?.title = "Animate"
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)

        return button
    }()

    var buttonTopAnchor: NSLayoutConstraint?
    var buttonTopOnConstraint: CGFloat = 64
    var buttonTopOffConstraint: CGFloat = 1000
    var buttonHeightAnchor: NSLayoutConstraint?
    var buttonHeightFirstConstraint: CGFloat = 50
    var buttonHeightSecondConstraint: CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setup()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.animateButton()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.fadeAnimation()
        }
    }

    func setup() {
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 2),
        ])
        buttonTopAnchor = button.topAnchor.constraint(equalTo: view.topAnchor, constant: buttonTopOffConstraint)
        buttonTopAnchor?.isActive = true

        buttonHeightAnchor = button.heightAnchor.constraint(equalToConstant: buttonHeightFirstConstraint)
        buttonHeightAnchor?.isActive = true
    }

    @objc func animate() {
        UIView.animate(withDuration: 2.0) {
            self.buttonHeightAnchor?.constant = CGFloat(CFloat.random(in: 25 ... 150))
            self.view.layoutIfNeeded()
        }
    }

    func animateButton() {
        let animation1 = UIViewPropertyAnimator(duration: 5.0, curve: .easeIn) { [weak self] in
            self?.buttonTopAnchor?.constant = self?.buttonTopOnConstraint ?? 64
            self?.view.layoutIfNeeded()
        }

        animation1.startAnimation()
    }

    func fadeAnimation() {
        let animation = UIViewPropertyAnimator(duration: 4, curve: .linear) {
            self.button.alpha = 1
        }

        animation.startAnimation()
    }
}

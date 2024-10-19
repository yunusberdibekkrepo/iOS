//
//  LoginViewController.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 6.09.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    private let inputFields: LoginInputFieldsView = .init()

    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.alignment = .center
        stack.alpha = 0

        return stack
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bankey"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = .center

        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your premium source for all things banking!"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()

    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title = "Sign In"
        button.configuration?.imagePadding = 8

        return button
    }()

    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.systemRed
        label.numberOfLines = 0
        label.isHidden = true

        return label
    }()

    var username: String? {
        inputFields.usernameField.text
    }

    var password: String? {
        inputFields.passwordField.text
    }

    let leadingEdgeOnScreen: CGFloat = 16
    let leadingEdgeOffScreen: CGFloat = -1000
    var titleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        layout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        signInButton.configuration?.showsActivityIndicator = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animate()
    }
}

// MARK: - Private Methods

private extension LoginViewController {
    func setUp() {
        view.backgroundColor = UIColor.systemBackground

        inputFields.translatesAutoresizingMaskIntoConstraints = false
        inputFields.enablePasswordToggle()
        signInButton.addTarget(self,
                               action: #selector(onTapSignInButton),
                               for: .primaryActionTriggered)
    }

    func layout() {
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)

        view.addSubview(vStack)
        view.addSubview(inputFields)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)

        NSLayoutConstraint.activate(
            [
                inputFields.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor),
                inputFields.leadingAnchor.constraint(
                    equalToSystemSpacingAfter: view.leadingAnchor,
                    multiplier: 1
                ),
                view.trailingAnchor.constraint(
                    equalToSystemSpacingAfter: inputFields.trailingAnchor,
                    multiplier: 1
                ),
            ]
        )

        NSLayoutConstraint.activate(
            [
                vStack.bottomAnchor.constraint(
                    equalTo: inputFields.topAnchor,
                    constant: -24
                ),

                vStack.trailingAnchor.constraint(
                    equalTo: inputFields.trailingAnchor
                ),
            ]
        )

        titleLeadingAnchor = vStack.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: leadingEdgeOffScreen
        )
        titleLeadingAnchor?.isActive = true

        NSLayoutConstraint.activate(
            [
                signInButton.topAnchor.constraint(
                    equalToSystemSpacingBelow: inputFields.bottomAnchor,
                    multiplier: 2
                ),
                signInButton.leadingAnchor.constraint(
                    equalTo: inputFields.leadingAnchor
                ),
                signInButton.trailingAnchor.constraint(
                    equalTo: inputFields.trailingAnchor
                ),
            ]
        )

        NSLayoutConstraint.activate(
            [
                errorMessageLabel.topAnchor.constraint(
                    equalToSystemSpacingBelow: signInButton.bottomAnchor,
                    multiplier: 2
                ),
                errorMessageLabel.leadingAnchor.constraint(
                    equalTo: inputFields.leadingAnchor
                ),
                errorMessageLabel.trailingAnchor.constraint(
                    equalTo: inputFields.trailingAnchor
                ),
            ]
        )
    }

    func configureErrorLabel(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message

        shakeButton()
    }

    func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4

        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}

/// LoginViewController + Actions
private extension LoginViewController {
    @objc
    func onTapSignInButton(sender: UIButton) {
        errorMessageLabel.isHidden = false

        login()
    }

    func login() {
        guard let username, let password else {
            assertionFailure("Should username / password never be nil")
            return
        }

        if username.isEmpty || password.isEmpty {
            configureErrorLabel(withMessage: "Username / password cannot be blank")
            return
        }

        if username == "Yunus", password == "yunus" {
            signInButton.configuration?.showsActivityIndicator = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.signInButton.configuration?.showsActivityIndicator = false
                appContainer.router.changeRootViewController(with: MainViewController())
            }
        } else {
            configureErrorLabel(withMessage: "Incorrect username / passsword")
        }
    }
}

private extension LoginViewController {
    func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }

        animator1.startAnimation()

        let animator2 = UIViewPropertyAnimator(duration: 4.0, curve: .easeInOut) {
            self.vStack.alpha = 1
            self.view.layoutIfNeeded()
        }

        animator2.startAnimation()
    }
}

#Preview {
    LoginViewController()
}

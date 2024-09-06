//
//  LoginInputFieldsView.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 6.09.2024.
//

import UIKit

final class LoginInputFieldsView: UIView {
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8

        return stack
    }()

    let usernameField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.placeholder = "Username"

        return textField
    }()

    let passwordField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.textAlignment = .left
        textField.placeholder = "Password"

        return textField
    }()

    let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUp()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginInputFieldsView {
    func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.secondarySystemBackground
        layer.cornerRadius = 8
        clipsToBounds = true

        usernameField.delegate = self
        passwordField.delegate = self
    }

    func layout() {
        vStack.addArrangedSubview(usernameField)
        vStack.addArrangedSubview(divider)
        vStack.addArrangedSubview(passwordField)
        addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(
                equalToSystemSpacingBelow: topAnchor,
                multiplier: 1),
            vStack.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 1),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: vStack.trailingAnchor,
                multiplier: 1),
            bottomAnchor.constraint(
                equalToSystemSpacingBelow: vStack.bottomAnchor,
                multiplier: 1)
        ])

        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

// MARK: - LoginView + UITextFieldDelegate

extension LoginInputFieldsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameField.endEditing(true)
        passwordField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {}
}

#Preview {
    LoginInputFieldsView()
}

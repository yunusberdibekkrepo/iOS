//
//  FirstTableCell.swift
//  TableViewActions
//
//  Created by Yunus Emre Berdibek on 22.10.2024.
//

import UIKit

final class FirstTableCell: UITableViewCell {
    static let reuseIdentifier: String = "FirstTableCell"

    var nameTextFieldCallBack: ((String) -> Void)?

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 0
        textField.font = .preferredFont(forTextStyle: .subheadline)
        textField.placeholder = "Name"

        return textField
    }()

    lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        textField.font = .preferredFont(forTextStyle: .subheadline)
        textField.placeholder = "Description"

        return textField
    }()

    lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 4

        return stackView
    }()

    lazy var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiaryLabel

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        selectionStyle = .none
        backgroundColor = .systemBackground
        layer.cornerRadius = 8

        nameTextField.delegate = self

        setupVStack()
    }

    func setupVStack() {
        contentView.addSubview(vStack)
        vStack.addArrangedSubview(nameTextField)
        vStack.addArrangedSubview(divider)
        vStack.addArrangedSubview(descriptionTextField)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            vStack.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: vStack.trailingAnchor, multiplier: 2),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: vStack.bottomAnchor, multiplier: 2),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension FirstTableCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }

        print("Tag: \(textField.tag)")
        nameTextFieldCallBack?(text)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            nameTextFieldCallBack?(updatedText)
        }

        return true
    }
}

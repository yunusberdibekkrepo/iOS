//
//  FirstTableCell.swift
//  TableViewActions
//
//  Created by Yunus Emre Berdibek on 22.10.2024.
//

import UIKit

final class FirstTableCell: UITableViewCell {
    static let reuseIdentifier: String = "FirstTableCell"

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(forTextStyle: .subheadline)
        textField.placeholder = "Name"

        return textField
    }()

    lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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

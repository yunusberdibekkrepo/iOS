//
//  OnboardItemViewController.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 7.09.2024.
//

import UIKit

final class OnboardItemViewController: UIViewController {
    private let onboardView: OnboardItemView

    init(onboardItem: OnboardItem) {
        self.onboardView = OnboardItemView(with: onboardItem)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        layout()
    }
}

private extension OnboardItemViewController {
    func setUp() {
        view.backgroundColor = UIColor.systemBackground

        onboardView.translatesAutoresizingMaskIntoConstraints = false
    }

    func layout() {
        view.addSubview(onboardView)

        NSLayoutConstraint.activate(
            [
                onboardView.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor
                ),
                onboardView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor
                ),
                onboardView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor
                ),
                view.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor
                ),
            ]
        )
    }
}

final class OnboardItemView: UIView {
    private let onboardItem: OnboardItem

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        return stackView
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    init(with onboardItem: OnboardItem) {
        self.onboardItem = onboardItem
        super.init(frame: .zero)

        setUp()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OnboardItemView {
    func setUp() {
        backgroundColor = UIColor.systemBackground
        translatesAutoresizingMaskIntoConstraints = false

        imageView.image = onboardItem.image
        titleLabel.text = onboardItem.text
    }

    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)

        NSLayoutConstraint.activate(
            [
                stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
                trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            ]
        )
    }
}

#Preview {
    OnboardItemViewController(onboardItem: .items.first!)
}

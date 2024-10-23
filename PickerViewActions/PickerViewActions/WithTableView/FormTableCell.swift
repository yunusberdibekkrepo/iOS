//
//  FormTableCell.swift
//  PickerViewActions
//
//  Created by Yunus Emre Berdibek on 23.10.2024.
//

import UIKit

final class FormTableCell: UITableViewCell {
    protocol FormTableCellDelegate: AnyObject {
        func didTapImageView(_ cell: FormTableCell)
    }

    static let reuseID: String = "FormTableCell"
    weak var delegate: FormTableCellDelegate?

    lazy var defaultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.text = "messi"

        return label
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
        accessoryType = .none
        contentView.isUserInteractionEnabled = true
        defaultImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
        defaultImageView.isUserInteractionEnabled = true
        contentView.addSubview(defaultImageView)
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            defaultImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            defaultImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            label.topAnchor.constraint(equalTo: defaultImageView.topAnchor, constant: 18),
            label.centerXAnchor.constraint(equalTo: defaultImageView.centerXAnchor),
        ])
    }

    func configure(_ image: String) {
        defaultImageView.image = UIImage(systemName: image)?.withRenderingMode(.alwaysTemplate)
    }

    func configure(withText text: String) {
        label.text = text
    }

    @objc func didTapImage() {
        delegate?.didTapImageView(self)
    }
}

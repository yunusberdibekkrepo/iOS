//
//  ViewController.swift
//  TableViewActions
//
//  Created by Yunus Emre Berdibek on 22.10.2024.
//

import UIKit

class ViewController: UIViewController {
    enum TableTitle: Int {
        case first
        case second
        case third

        var title: String {
            switch self {
            case .first:
                "First"
            case .second:
                "Second"
            case .third:
                "Third"
            }
        }
    }

    var values: [String] = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth"]

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(FirstTableCell.self, forCellReuseIdentifier: FirstTableCell.reuseIdentifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        view.backgroundColor = .secondarySystemBackground
        tableView.backgroundColor = .secondarySystemBackground

        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 3),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableTitle = TableTitle(rawValue: section)

        return tableTitle?.title
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableTitle = TableTitle(rawValue: indexPath.section)

        switch tableTitle {
        case .first:
            return 100
        default:
            return 50
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = TableTitle(rawValue: indexPath.section)

        switch section {
        case .first:
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableCell.reuseIdentifier) as! FirstTableCell

            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            var configuration = cell.defaultContentConfiguration()
            let value = values[indexPath.row]
            configuration.text = value
            configuration.image = UIImage(systemName: "heart.fill")
            cell.contentConfiguration = configuration

            return cell
        }
    }
}

//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 8.10.2024.
//

import UIKit

final class AccountSummaryViewController: UIViewController {
    // MARK: - Variables

    var profile: Profile?
    var accounts: [Account] = []

    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome",
                                                             name: "Yunus Emre",
                                                             date: .now)
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []

    // MARK: - UI Components

    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        barButtonItem.tintColor = .label

        return barButtonItem
    }()

    var headerView = AccountSummaryHeaderView(frame: .zero)

    var tableView = UITableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = appContainer.theme.appColor
        navigationItem.rightBarButtonItem = logoutBarButtonItem

        setupTableView()
        setupTableHeaderView()
        fetchData()
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseIdentifier)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView() /// footer yok anlamında.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupTableHeaderView() {
        /// UIView.layoutFittingCompressedSize ile en uygun height ayarlanıyor.
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size

        tableView.tableHeaderView = headerView
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifier, for: indexPath) as? AccountSummaryCell else {
            fatalError("Unsupported cell type")
        }

        let account = accountCellViewModels[indexPath.row]
        cell.configure(with: account)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension AccountSummaryViewController {
    @objc
    func logout() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

// MARK: - Networking

extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()

        group.enter()
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }

            group.leave()
        }

        group.enter()
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
            case .failure(let error):
                print(error.localizedDescription)
            }

            group.leave()
        }

        group.notify(queue: .main) { // Dispatch group'a giren iki işlem bittikten sonra çalışır.
            self.tableView.reloadData()
        }
    }

    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type,
                                         accountName: $0.name,
                                         balance: $0.amount)
        }
    }

    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(with: vm)
    }
}

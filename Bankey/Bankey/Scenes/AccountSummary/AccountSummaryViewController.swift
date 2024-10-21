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
    var isLoaded = false

    // MARK: - UI Components

    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        barButtonItem.tintColor = .label

        return barButtonItem
    }()

    var headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    let refreshControl = UIRefreshControl()

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
        setupRefreshControl()
        setupSkelatons()
        fetchData()
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseIdentifier)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
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

    private func setupRefreshControl() {
        refreshControl.tintColor = appContainer.theme.appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func setupSkelatons() {
        let row = Account.makeSkelaton()
        accounts = Array(repeating: row, count: 10)

        configureTableCells(with: accounts)
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        let account = accountCellViewModels[indexPath.row]

        if isLoaded {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifier, for: indexPath) as? AccountSummaryCell else {
                fatalError("Unsupported cell type")
            }

            cell.configure(with: account)
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as? SkeletonCell else {
            fatalError("Unsupported cell type")
        }

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
    @objc func logout() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }

    @objc func refreshContent() {
        reset()
        setupSkelatons()
        tableView.reloadData()
        fetchData()
    }

    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
}

// MARK: - Networking

extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()
        let userId = String(Int.random(in: 1 ..< 4))

        group.enter()
        fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let failure):
                print(failure.localizedDescription)
            }

            group.leave()
        }

        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                print(error.localizedDescription)
            }

            group.leave()
        }

        // Dispatch group'a giren iki işlem bittikten sonra çalışır.
        group.notify(queue: .main) {
            self.tableView.refreshControl?.endRefreshing()

            guard let profile = self.profile else { return }
            self.isLoaded = true
            self.configureTableHeaderView(with: profile)
            self.configureTableCells(with: self.accounts)
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

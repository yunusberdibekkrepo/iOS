//
//  ViewController.swift
//  SegmentedControlActions
//
//  Created by Yunus Emre Berdibek on 23.10.2024.
//

import UIKit

class ViewController: UIViewController {
    let countries = ["Turkey", "England", "France", "Germany", "Italy", "Spain"]
    let cities = ["Ankara", "London", "Paris", "Berlin", "Rome", "Madrid"]

    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Countries", "Cities"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()

    lazy var countriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    lazy var citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateTableViewVisibility()
    }

    func setupView() {
        view.backgroundColor = .systemBackground

        view.addSubview(segmentedControl)
        view.addSubview(countriesTableView)
        view.addSubview(citiesTableView)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: segmentedControl.trailingAnchor, multiplier: 2),

            countriesTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            citiesTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            citiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            citiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func segmentedControlValueChanged() {
        updateTableViewVisibility()
    }

    func updateTableViewVisibility() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        countriesTableView.isHidden = selectedIndex != 0
        citiesTableView.isHidden = selectedIndex != 1
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == countriesTableView {
            return countries.count
        } else if tableView == citiesTableView {
            return cities.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if tableView == countriesTableView {
            cell.textLabel?.text = countries[indexPath.row]
        } else if tableView == citiesTableView {
            cell.textLabel?.text = cities[indexPath.row]
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == countriesTableView {
            let selectedCountry = countries[indexPath.row]
            print("SelectedCountry: \(selectedCountry)")
        } else if tableView == citiesTableView {
            let selectedCity = cities[indexPath.row]
            print("SelectedCity: \(selectedCity)")
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

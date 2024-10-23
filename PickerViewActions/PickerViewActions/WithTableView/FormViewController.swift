//
//  FormViewController.swift
//  PickerViewActions
//
//  Created by Yunus Emre Berdibek on 23.10.2024.
//

import UIKit

final class FormViewController: UIViewController {
    let countries: [String] = ["Turkey", "England", "France", "Germany", "Italy", "Spain"]
    let cities: [String] = ["Ankara", "London", "Paris", "Berlin", "Rome", "Madrid"]
    let images: [String] = ["heart.fill", "folder.fill"]

    var selectedCountryRow: Int = 0
    var selectedCityRow: Int = 0

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FormTableCell.self, forCellReuseIdentifier: FormTableCell.reuseID)
        tableView.rowHeight = 48

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func showCountryPicker(cell: FormTableCell) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.view.layer.cornerRadius = 12
        viewController.preferredContentSize = view.bounds.size

        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedCountryRow, inComponent: 0, animated: false)
        viewController.view.addSubview(pickerView)

        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
        ])

        let alertController = UIAlertController(title: "Choose a country", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a velit purus. Proin rhoncus ultrices erat eget feugiat. Donec vitae ultricies tortor. In vestibulum tristique enim in mattis.", preferredStyle: .actionSheet)
        alertController.setValue(viewController, forKey: "ContentViewController")

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let selectAction = UIAlertAction(title: "Select", style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.selectedCountryRow = pickerView.selectedRow(inComponent: 0)
            cell.configure(withText: countries[selectedCountryRow])
        }
        alertController.addAction(cancelAction)
        alertController.addAction(selectAction)
        present(alertController, animated: true)
    }

    func showCityPicker(cell: FormTableCell) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.view.layer.cornerRadius = 12
        viewController.preferredContentSize = view.bounds.size

        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedCityRow, inComponent: 0, animated: false)
        viewController.view.addSubview(pickerView)

        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
        ])

        let alertController = UIAlertController(title: "Choose a country", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a velit purus. Proin rhoncus ultrices erat eget feugiat. Donec vitae ultricies tortor. In vestibulum tristique enim in mattis.", preferredStyle: .actionSheet)
        alertController.setValue(viewController, forKey: "ContentViewController")

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let selectAction = UIAlertAction(title: "Select", style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.selectedCountryRow = pickerView.selectedRow(inComponent: 0)
            cell.configure(withText: cities[selectedCountryRow])
        }
        alertController.addAction(cancelAction)
        alertController.addAction(selectAction)
        present(alertController, animated: true)
    }
}

extension FormViewController: FormTableCell.FormTableCellDelegate {
    func didTapImageView(_ cell: FormTableCell) {
        showCountryPicker(cell: cell)
    }
}

extension FormViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableCell.reuseID, for: indexPath) as! FormTableCell
        let image = images[indexPath.row]

        cell.delegate = self
        cell.configure(image)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension FormViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return countries.count
        case 1:
            return cities.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return countries[row]
        case 1:
            return cities[row]
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            selectedCountry = countries[row]
        case 1:
            selectedCity = cities[row]
        default:
            break
        }
    }
}

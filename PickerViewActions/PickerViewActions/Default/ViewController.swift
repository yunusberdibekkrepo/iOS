//
//  ViewController.swift
//  PickerViewActions
//
//  Created by Yunus Emre Berdibek on 23.10.2024.
//

import UIKit

final class ViewController: UIViewController {
    let countries: [String] = ["Turkey", "England", "France", "Germany", "Italy", "Spain"]
    let cities: [String] = ["Ankara", "London", "Paris", "Berlin", "Rome", "Madrid"]
    var selectedCountry: String?
    var selectedCity: String?
    var selectedCountryRow: Int = 0

    lazy var countryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select a country", for: .normal) // Başlık ayarı
        button.setTitleColor(.red, for: .normal) // Başlık rengi ayarı
        button.addTarget(self, action: #selector(countryButtonAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        view.backgroundColor = .systemBackground

        setupButton()
    }

    func setupButton() {
        view.addSubview(countryButton)

        NSLayoutConstraint.activate([
            countryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        ])
    }

    @objc func countryButtonAction() {
        showCountryPicker()
    }

    func showCountryPicker() {
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
        alertController.popoverPresentationController?.sourceView = countryButton
        alertController.popoverPresentationController?.sourceRect = countryButton.bounds
        alertController.setValue(viewController, forKey: "ContentViewController")

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let selectAction = UIAlertAction(title: "Select", style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.selectedCountryRow = pickerView.selectedRow(inComponent: 0)
            self.countryButton.setTitle(self.countries[self.selectedCountryRow], for: .normal)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(selectAction)
        present(alertController, animated: true)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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

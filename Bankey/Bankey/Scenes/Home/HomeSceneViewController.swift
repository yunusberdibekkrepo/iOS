//
//  HomeSceneViewController.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 9.09.2024.
//

import Foundation

import UIKit

final class HomeSceneViewController: UIViewController {
    private var viewModel: HomeSceneViewModelProtocol?

    override func viewDidLoad() {
        setUp()
        viewModel?.dataSource = self
        viewModel?.delegate = self

        viewModel?.viewDidLoad()
    }
}

// MARK: - Private Methods

private extension HomeSceneViewController {
    func setUp() {}
}

// MARK: - HomeSceneViewController + HomeSceneViewModelDataSource

extension HomeSceneViewController: HomeSceneViewModelDataSource {
    var width: CGFloat {
        view.frame.width
    }
}

// MARK: - HomeSceneViewController + HomeSceneViewModelDelegate

extension HomeSceneViewController: HomeSceneViewModelDelegate {
    func handleOutput() {}
}

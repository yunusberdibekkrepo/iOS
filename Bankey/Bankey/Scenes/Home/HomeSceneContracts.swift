//
//  HomeSceneContracts.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 9.09.2024.
//

import UIKit

/// Confirm HomeSceneViewModel
protocol HomeSceneViewModelProtocol {
    var delegate: HomeSceneViewModelDelegate? { get set }
    var dataSource: HomeSceneViewModelDataSource? { get set }

    func viewDidLoad()
}

/// ViewModel tarafından viewController'in kullanması için hazırlanan veri.
protocol HomeSceneViewModelDelegate: AnyObject {
    func handleOutput()
}

/// ViewController tarafından viewModel'in kullanması için hazırlanan veri.
protocol HomeSceneViewModelDataSource: AnyObject {
    var width: CGFloat { get }
}

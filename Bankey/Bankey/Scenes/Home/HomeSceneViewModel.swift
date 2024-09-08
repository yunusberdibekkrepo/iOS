//
//  HomeSceneViewModel.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 9.09.2024.
//

import Foundation

final class HomeSceneViewModel: HomeSceneViewModelProtocol {
    weak var delegate: HomeSceneViewModelDelegate?
    weak var dataSource: HomeSceneViewModelDataSource?

    func viewDidLoad() {}
}

//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 6.09.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    let pageViewController: UIPageViewController
    var pages: [UIViewController] = []
    var currentPage: UIViewController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        for item in OnboardItem.items {
            let controller = OnboardItemViewController(onboardItem: item)

            pages.append(controller)
        }

        currentPage = pages.first!

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        layout()
    }
}

private extension OnboardingViewController {
    func setUp() {
        view.backgroundColor = .purple
        addChild(pageViewController)
        view.addSubview(pageViewController.view)

        pageViewController.didMove(toParent: self)
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }

    func layout() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])

        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentPage = pages.first!
    }
}

// MARK: - OnboardingViewController +UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        getViewControllerBefore(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        getViewControllerNext(from: viewController)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        pages.firstIndex(of: self.currentPage) ?? 0
    }
}

// MARK: - OnboardingViewController + UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {}

// MARK: - OnboardingViewController + Actions

private extension OnboardingViewController {
    func getViewControllerBefore(from controller: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: controller),
              currentIndex != 0
        else {
            return nil
        }

        currentPage = pages[currentIndex - 1]
        return currentPage
    }

    func getViewControllerNext(from controller: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: controller),
              currentIndex + 1 < pages.count
        else {
            return nil
        }

        currentPage = pages[currentIndex + 1]
        return currentPage
    }
}

#Preview {
    OnboardingViewController()
}

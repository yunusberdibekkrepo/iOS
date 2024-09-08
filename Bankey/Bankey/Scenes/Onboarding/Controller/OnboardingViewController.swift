//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 6.09.2024.
//

import UIKit

final class OnboardingViewController: UIPageViewController {
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.currentPageIndicatorTintColor = .white
        control.backgroundColor = .purple

        return control
    }()

    var pages: [UIViewController] = []
    var initialIndex: Int = 0

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: navigationOrientation,
                   options: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        setUpPageControl()
    }
}

private extension OnboardingViewController {
    func setUp() {
        view.backgroundColor = .purple
        delegate = self
        dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(onTapNextButton)
        )

        pages = OnboardItem.items.map { OnboardItemViewController(onboardItem: $0) }
        setViewControllers([pages[initialIndex]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }

    func setUpPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialIndex

        view.addSubview(pageControl)

        NSLayoutConstraint.activate(
            [
                pageControl.widthAnchor.constraint(
                    equalTo: view.widthAnchor
                ),
                pageControl.heightAnchor.constraint(
                    equalTo: view.heightAnchor,
                    multiplier: 0.05
                ),
                pageControl.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor
                )
            ]
        )
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
}

// MARK: - OnboardingViewController + UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let controllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: controllers[0]) else { return }

        pageControl.currentPage = currentIndex
        changeNextButtonTitle(at: currentIndex)
    }
}

// MARK: - OnboardingViewController + Actions

private extension OnboardingViewController {
    @objc func onTapPageControl() {
        print("onTapPageControl")
    }

    @objc func onTapNextButton() {
        if pageControl.currentPage == (pages.count - 1) {
            UserDefaults.standard.setValue(true, forKey: "hasOnboarded")
            
            appContainer.router.changeRootViewController(with: LoginViewController())
        }
        print("Tıklandı index: \(pageControl.currentPage)")
    }

    func getViewControllerBefore(from controller: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: controller) else {
            return nil
        }

        if currentIndex == 0 {
            return nil
        }

        return pages[currentIndex - 1]
    }

    func getViewControllerNext(from controller: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: controller) else {
            return nil
        }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        }

        return nil
    }

    func changeNextButtonTitle(at index: Int) {
        if index == 2 {
            navigationItem.rightBarButtonItem?.title = "Start"
        } else {
            navigationItem.rightBarButtonItem?.title = "Next"
        }
    }
}

#Preview {
    UINavigationController(rootViewController: OnboardingViewController())
}

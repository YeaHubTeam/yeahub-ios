import UIKit
import SwiftUI
import CommonUI

final class YHTabBarController: UITabBarController {

    private let floatingButton = FloatingTabButton()
    private let buttonLabel = UILabel()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideOriginalCenterTabItem()
        updateQuestionsLabelTextlColor()
        updateFloatingButtonSelection()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        positionFloatingButton()
        positionButtonLabel()
    }

    // MARK: Private methods

    private func setupUI() {
        setupFloatingButton()
        setupButtonLabel()
        setupTabBarAppearance()

        delegate = self
        
        updateQuestionsLabelTextlColor()
        updateFloatingButtonSelection()
    }

    private func setupFloatingButton() {
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        view.addSubview(floatingButton)
    }

    private func setupButtonLabel() {
        buttonLabel.text = "Вопросы"
        buttonLabel.font = UIFont.manrope(.medium, size: Constants.buttonFontSize)
        buttonLabel.textAlignment = .center
        updateQuestionsLabelTextlColor()
        buttonLabel.sizeToFit()
        view.addSubview(buttonLabel)
    }

    private func positionFloatingButton() {
        let buttonSize: CGFloat = Constants.buttonSize
        let tabBarHeight = tabBar.frame.height
        let yPosition = view.bounds.height - tabBarHeight - buttonSize / 2

        floatingButton.frame = CGRect(
            x: view.bounds.midX - buttonSize / 2,
            y: yPosition,
            width: buttonSize,
            height: buttonSize
        )

        view.bringSubviewToFront(floatingButton)
    }

    private func positionButtonLabel() {
        buttonLabel.frame = CGRect(
            x: floatingButton.frame.midX - buttonLabel.bounds.width / 2,
            y: floatingButton.frame.maxY + Constants.buttonLabelOffset,
            width: buttonLabel.bounds.width,
            height: buttonLabel.bounds.height
        )
        view.bringSubviewToFront(buttonLabel)
    }

    private func hideOriginalCenterTabItem() {
        guard let items = tabBar.items, items.count > 1 else { return }

        items[1].image = nil
        items[1].selectedImage = nil
        items[1].title = nil
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()

        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(Color.pureWhite)

        let normalItemAppearance = appearance.stackedLayoutAppearance.normal
        let selectedItemAppearance = appearance.stackedLayoutAppearance.selected

        normalItemAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.secondaryLabel,
            .font: UIFont.manrope(.medium, size: Constants.tabBarItemFontSize)
        ]

        selectedItemAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.purple700),
            .font: UIFont.manrope(.medium, size: Constants.tabBarItemFontSize)
        ]

        normalItemAppearance.iconColor = .secondaryLabel
        selectedItemAppearance.iconColor = UIColor(Color.purple700)

        appearance.stackedItemPositioning = .centered

        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        tabBar.isTranslucent = true
        tabBar.tintAdjustmentMode = .normal
    }

    private func updateQuestionsLabelTextlColor() {
        if selectedIndex == 1 {
            buttonLabel.textColor = UIColor(Color.purple700)
        } else {
            buttonLabel.textColor = UIColor.secondaryLabel
        }
    }

    private func updateFloatingButtonSelection() {
        floatingButton.isSelected = (selectedIndex == 1)
    }

    // MARK: Handlers

    @objc private func floatingButtonTapped() {
        selectedIndex = 1
        updateFloatingButtonSelection()
        updateQuestionsLabelTextlColor()

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            self.floatingButton.transform = CGAffineTransform(rotationAngle: -20 * .pi / 180)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.3,
                           initialSpringVelocity: 0.7,
                           options: .curveEaseOut,
                           animations: {
                self.floatingButton.transform = .identity
            })
        })
    }

    // MARK: - Status Bar Management

    override var prefersStatusBarHidden: Bool {
        return selectedViewController?.prefersStatusBarHidden ?? false
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return selectedViewController?.preferredStatusBarUpdateAnimation ?? .slide
    }

    override var childForStatusBarHidden: UIViewController? {
        return selectedViewController
    }

    override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }
}

// MARK: - UITabBarControllerDelegate

extension YHTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setNeedsStatusBarAppearanceUpdate()
        updateFloatingButtonSelection()
        updateQuestionsLabelTextlColor()
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        if let index = viewControllers?.firstIndex(of: viewController) {
            floatingButton.isSelected = (index == 1)
            buttonLabel.textColor = (index == 1) ? UIColor(Color.purple700) : UIColor.secondaryLabel
        }
        return true
    }
}

extension YHTabBarController {

    private enum Constants {

        static let buttonSize: CGFloat = 60
        static let buttonFontSize: CGFloat = 12
        static let buttonLabelOffset: CGFloat = 4

        static let tabBarItemFontSize: CGFloat = 12
    }
}

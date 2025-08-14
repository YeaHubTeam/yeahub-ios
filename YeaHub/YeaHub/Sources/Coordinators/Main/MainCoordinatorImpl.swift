import SwiftUI
import NavigationKit
import CommonUI

class MainCoordinatorImpl: BaseCoordinator, MainCoordinator {

    var factory: MainFactory

    private weak var tabBarController: UITabBarController?
    private let router: Router

    private var childCoordinators: [Coordinator] = []

    init(
        router: Router,
        factory: MainFactory
    ) {
        self.router = router
        self.factory = factory
        super.init()
    }

    func start() {
        showTabBar()
    }

    private func showTabBar() {
        let tabBarController = YHTabBarController() // Используем наш кастомный контроллер
        self.tabBarController = tabBarController

        configureTabs(for: tabBarController)

        router.setRoot(tabBarController, animated: true)
    }

    private func configureTabs(for tabBarController: UITabBarController) {
        // Создаем координаторы
        let homeCoordinator = factory.makeHomeCoordinator(router: router)
        let questionsCoordinator = factory.makeQuestionsOnboardingCoordinator(router: router)
//        let collectionsCoordinator = factory.makeCollectionsCoordinator(router: router)

        childCoordinators.append(homeCoordinator)
        childCoordinators.append(questionsCoordinator)

        homeCoordinator.start()
        questionsCoordinator.start()
//        collectionsCoordinator.start()

        let collectionsVC = UIViewController()
        guard let homeVC = homeCoordinator.getHomeScreen()?.toPresent(),
              let questionsVC = questionsCoordinator.getQuestionsOnboardingScreen()?.toPresent()
//              let collectionsVC = collectionsCoordinator.toPresent()
        else {
            return
        }

        let homeNav: UINavigationControllerType
        if let nav = homeVC as? UINavigationController {
            homeNav = nav
        } else {
            homeNav = UINavigationController(rootViewController: homeVC)
        }

        homeNav.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let questionsNav: UINavigationControllerType
        if let nav = questionsVC as? UINavigationController {
            questionsNav = nav
        } else {
            questionsNav = UINavigationController(rootViewController: questionsVC)
        }

        questionsNav.tabBarItem = UITabBarItem(
            title: "Вопросы",
            image: nil,
            selectedImage: nil
        )

        collectionsVC.tabBarItem = UITabBarItem(
            title: "Коллекции",
            image: UIImage(systemName: "square.stack.3d.up"),
            selectedImage: UIImage(systemName: "square.stack.3d.up.fill")
        )

        tabBarController.viewControllers = [homeNav, questionsNav, collectionsVC]
    }

    func openFirstTab() {
        tabBarController?.selectedIndex = 0
    }
}

import SwiftUI
import NavigationKit
import CommonUI

class MainCoordinatorImpl: BaseCoordinator, MainCoordinator {

    var factory: MainFactory

    private weak var tabBarController: UITabBarController?
    private let router: Router

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

        // Настраиваем табы
        homeVC.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(named: "HomeIcon"),
            tag: 0
        )

        // Центральный таб - оставляем пустым, так как у нас кастомная кнопка
        questionsVC.tabBarItem = UITabBarItem(
            title: "Вопросы",
            image: nil,
            selectedImage: nil
        )

        collectionsVC.tabBarItem = UITabBarItem(
            title: "Коллекции",
            image: UIImage(named: "CollectionsIcon"),
            tag: 0
        )

        tabBarController.viewControllers = [homeVC, questionsVC, collectionsVC]
    }

    func openFirstTab() {
        tabBarController?.selectedIndex = 0
    }
}

import NavigationKit
import UIKit

public func makeHomeCoordinator(
    router: Router
) -> HomeCoordinator {

    let coordinator = HomeCoordinatorImpl(
        router: router,
        factory: HomeFactoryImpl()
    )
    return coordinator
}

public class HomeCoordinatorImpl: HomeCoordinator {

    public var router: Router
    public var factory: HomeFactory
    private var homeScreen: HomeViewController?

    public init(
        router: Router,
        factory: HomeFactory
    ) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        homeScreen = factory.makeHomeScreen(
            onQuestionsSelected: { [weak self] in
                self?.goToQuestionsTab()
            },
            onCollectionsSelected: { [weak self] in
                self?.goToCollectionsTab()
            }
        )
    }

    public func getHomeScreen() -> HomeViewController? {
        if homeScreen == nil {
            start()
        }
        return homeScreen
    }

    public func goToQuestionsTab() {
        if let tabBarController = router.window?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 1
        }
    }

    public func goToCollectionsTab() {
        if let tabBarController = router.window?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 2
        }
    }
}

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
        homeScreen = factory.makeHomeScreen()
    }

    public func getHomeScreen() -> HomeViewController? {
        if homeScreen == nil {
            start()
        }
        return homeScreen
    }
}

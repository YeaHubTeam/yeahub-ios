import NavigationKit

public class HomeFactoryImpl: HomeFactory {

    public init() {}

    public func makeHomeCoordinator(router: Router) -> HomeCoordinator {
        HomeCoordinatorImpl(router: router, factory: self)
    }

    public func makeHomeScreen() -> HomeViewController {
        HomeViewController()
    }
}

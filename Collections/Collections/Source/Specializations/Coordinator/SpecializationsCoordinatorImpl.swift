import NavigationKit

public func makeSpecializationsCoordinator(router: Router) -> SpecializationsCoordinator {
    SpecializationsCoordinatorImpl(router: router, factory: SpecializationsFactoryImpl())
}

public final class SpecializationsCoordinatorImpl: SpecializationsCoordinator {
    public var router: Router
    public var factory: SpecializationsFactory
    private var specializationsScreen: SpecializationsViewController?

    public init(router: Router, factory: SpecializationsFactory) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        specializationsScreen = factory.makeSpecializationsScreen()

        router.push(specializationsScreen)
    }

    public func getSpecializationsScreen() -> SpecializationsViewController? {
        if specializationsScreen == nil {
            start()
        }
        return specializationsScreen
    }
}

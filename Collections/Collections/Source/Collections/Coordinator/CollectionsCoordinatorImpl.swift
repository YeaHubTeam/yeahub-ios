import NavigationKit

public func makeCollectionsCoordinator(router: Router) -> CollectionsCoordinator {
    CollectionsCoordinatorImpl(router: router, factory: CollectionsFactoryImpl())
}

public final class CollectionsCoordinatorImpl: CollectionsCoordinator {
    public var router: Router
    public var factory: CollectionsFactory
    private var collectionScreen: CollectionsViewController?
    private var specializationCoordinator: SpecializationsCoordinator?

    public init(router: Router, factory: CollectionsFactory) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        collectionScreen = factory.makeCollectionsScreen(onSelectSpecializations: { [weak self] in
            self?.startSpecializationsFlow()
        })
    }

    public func getCollectionScreen() -> CollectionsViewController? {
        if collectionScreen == nil {
            start()
        }
        return collectionScreen
    }

    private func startSpecializationsFlow() {
        let specializationsFactory = SpecializationsFactoryImpl()
        let coordinator = SpecializationsCoordinatorImpl(router: router, factory: specializationsFactory)
        specializationCoordinator = coordinator
        coordinator.start()
    }
}

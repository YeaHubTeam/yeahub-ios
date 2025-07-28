import NavigationKit

class AppFactoryImpl: AppFactory {

    func makeMainCoordinator(router: Router) -> MainCoordinator {
        return MainCoordinatorImpl(
            router: router,
            factory: MainFactoryImpl()
        )
    }
}

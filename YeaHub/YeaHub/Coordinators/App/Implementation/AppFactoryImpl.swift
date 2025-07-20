class AppFactoryImpl: AppFactory {
    func makeMainCoordinator() -> MainCoordinator {
        return MainCoordinatorImpl()
    }
}

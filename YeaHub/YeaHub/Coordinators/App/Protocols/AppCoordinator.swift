protocol AppCoordinator {
    var appFactory: AppFactory { get }
    func start()
}

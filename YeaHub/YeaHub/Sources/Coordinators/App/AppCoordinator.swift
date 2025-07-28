import NeedleFoundation

protocol AppCoordinator: Dependency {
    var appFactory: AppFactory { get }
    func start()
}

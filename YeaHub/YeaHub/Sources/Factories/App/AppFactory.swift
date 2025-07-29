import NavigationKit

protocol AppFactory {

    func makeMainCoordinator(router: Router) -> MainCoordinator
}

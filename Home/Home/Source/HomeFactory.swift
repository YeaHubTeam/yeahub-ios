import NavigationKit

public protocol HomeFactory {

    func makeHomeCoordinator(router: Router) -> HomeCoordinator
    func makeHomeScreen() -> HomeViewController
}

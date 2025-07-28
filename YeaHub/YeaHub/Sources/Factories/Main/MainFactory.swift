import NavigationKit
import Home

protocol MainFactory {

    func makeTabBarScreen() -> TabBarScreen
    func makeHomeCoordinator(router: Router) -> HomeCoordinator
}

import UIKit
import NavigationKit
import Home

class MainFactoryImpl: MainFactory {

    func makeTabBarScreen() -> TabBarScreen {
        let screen = TabBarViewController()
        return screen
    }

    func makeHomeCoordinator(router: Router) -> HomeCoordinator {
        let coordinator = Home.makeHomeCoordinator(router: router)
        return coordinator
    }
}

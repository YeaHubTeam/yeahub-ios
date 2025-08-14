import SwiftUI
import NavigationKit

class AppCoordinatorImpl: AppCoordinator, ObservableObject {

    var appFactory: AppFactory
    let router: Router

    private var mainCoordinator: MainCoordinator?

    init(router: Router, appFactory: AppFactory) {
        self.router = router
        self.appFactory = appFactory
    }

    func start() {
        let coordinator = appFactory.makeMainCoordinator(router: router)
        self.mainCoordinator = coordinator
        coordinator.start()
    }
}

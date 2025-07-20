import SwiftUI

class AppCoordinatorImpl: AppCoordinator, ObservableObject {
    let appFactory: AppFactory

    init(appFactory: AppFactory) {
        self.appFactory = appFactory
    }

    func start() {
        let mainCoordinator = appFactory.makeMainCoordinator()
        mainCoordinator.start()
    }
}

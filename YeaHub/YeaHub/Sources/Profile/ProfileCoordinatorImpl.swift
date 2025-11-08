import NavigationKit
import UIKit

public func makeProfileCoordinator(
    router: Router
) -> ProfileCoordinator {

    let coordinator = ProfileCoordinatorImpl(
        router: router,
        factory: ProfileFactoryImpl()
    )
    return coordinator
}

public class ProfileCoordinatorImpl: ProfileCoordinator {

    public var router: Router
    public var factory: ProfileFactory
    private var profileScreen: ProfileViewController?

    public init(
        router: Router,
        factory: ProfileFactory
    ) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        profileScreen = factory.makeProfileScreen()
    }

    public func getProfileScreen() -> ProfileViewController? {
        if profileScreen == nil {
            start()
        }
        return profileScreen
    }
}

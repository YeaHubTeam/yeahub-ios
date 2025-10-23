import NavigationKit

public class ProfileFactoryImpl: ProfileFactory {

    public init() {}

    public func makeProfileCoordinator(router: Router) -> ProfileCoordinator {
        ProfileCoordinatorImpl(router: router, factory: self)
    }

    public func makeProfileScreen() -> ProfileViewController {
        ProfileViewController()
    }
}

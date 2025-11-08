import NavigationKit

public protocol ProfileFactory {

    func makeProfileCoordinator(router: Router) -> ProfileCoordinator
    func makeProfileScreen() -> ProfileViewController
}

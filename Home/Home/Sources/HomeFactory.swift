import NavigationKit

public protocol HomeFactory {

    func makeHomeCoordinator(router: Router) -> HomeCoordinator
    func makeHomeScreen(
        onQuestionsSelected: @escaping () -> Void,
        onCollectionsSelected: @escaping () -> Void
    ) -> HomeViewController
}

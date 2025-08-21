import NavigationKit

public protocol CollectionsFactory {
//    func makeCollectionsCoordinator(router: Router) -> CollectionsCoordinator
    func makeCollectionsScreen(onSelectSpecializations: @escaping () -> Void) -> CollectionsViewController
}

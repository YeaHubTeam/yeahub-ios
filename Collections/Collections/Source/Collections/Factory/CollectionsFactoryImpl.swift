import NavigationKit
import Networking

public final class CollectionsFactoryImpl: CollectionsFactory {
    public init() {}

//    public func makeCollectionsCoordinator(router: Router) -> CollectionsCoordinator {
//        CollectionsCoordinatorImpl(router: router, factory: self)
//    }

    public func makeCollectionsScreen(onSelectSpecializations: @escaping () -> Void) -> CollectionsViewController {
        let viewModel = CollectionsViewModel()
        return CollectionsViewController(viewModel: viewModel, onSelectSpecializations: onSelectSpecializations)
    }
}

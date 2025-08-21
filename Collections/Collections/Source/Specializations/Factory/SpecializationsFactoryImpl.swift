import NavigationKit
import Networking

public final class SpecializationsFactoryImpl: SpecializationsFactory {
    public init() {}

//    public func makeSpecializationsCoordinator(router: Router) -> SpecializationsCoordinator {
//        SpecializationsCoordinatorImpl(router: router, factory: self)
//    }

    public func makeSpecializationsScreen() -> SpecializationsViewController {
        let client = UrlSessionHttpClient()
        let repositoty = SpecializationsRepository(client: client)
        let viewModel = SpecializationsViewModel(repository: repositoty)
        return SpecializationsViewController(viewModel: viewModel)
    }
}

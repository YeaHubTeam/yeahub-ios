import NavigationKit
import Networking

public final class SpecializationsFactoryImpl: SpecializationsFactory {
    let router: Router
    public init(router: Router) {
        self.router = router
    }

    public func makeSpecializationsScreen() -> SpecializationsViewController {
        let client = UrlSessionHttpClient()
        let repositoty = SpecializationsRepository(client: client)
        let coordinator = SpecializationsCoordinatorImpl(router: router, factory: self)
        let viewModel = SpecializationsViewModel(repository: repositoty, coordinator: coordinator)
        return SpecializationsViewController(viewModel: viewModel)
    }
}

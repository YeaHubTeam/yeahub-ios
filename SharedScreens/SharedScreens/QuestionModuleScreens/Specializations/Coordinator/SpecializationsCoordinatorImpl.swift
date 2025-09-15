
import NavigationKit

public final class SpecializationsCoordinatorImpl: SpecializationsCoordinator {
    public var router: Router
    public var factory: SpecializationsFactory
    private var specializationsScreen: SpecializationsViewController?

    public init(router: Router, factory: SpecializationsFactory) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        specializationsScreen = factory.makeSpecializationsScreen()
        router.push(specializationsScreen, animated: true)
    }

    public func startQuestionFlow(id: Int, specializationTitle: String) {
        let coordinator = makeQuestionsListCoordinator(router: router)
        coordinator.start(with: id, specializationTitle: specializationTitle)
    }
}

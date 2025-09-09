import NavigationKit
import UIKit
import SharedScreens

public func makeQuestionsOnboardingCoordinator(
    router: Router
) -> QuestionsOnboardingCoordinator {

    let coordinator = QuestionsOnboardingCoordinatorImpl(
        router: router,
        factory: QuestionsOnboardingFactoryImpl()
    )
    return coordinator
}

public class QuestionsOnboardingCoordinatorImpl: QuestionsOnboardingCoordinator {

    public var router: Router
    public var factory: QuestionsOnboardingFactory
    private var questionsOnboardingScreen: QuestionsOnboardingViewController?
    private var specializationCoordinator: SpecializationsCoordinator?

    public init(
        router: Router,
        factory: QuestionsOnboardingFactory
    ) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        questionsOnboardingScreen = factory.makeQuestionsOnboardingScreen(onSelectSpecializations: { [weak self] in
            self?.startSpecializationsFlow()
        })
    }

    public func getQuestionsOnboardingScreen() -> QuestionsOnboardingViewController? {
        if questionsOnboardingScreen == nil {
            start()
        }
        return questionsOnboardingScreen
    }

    private func startSpecializationsFlow() {
        let specializationsFactory = SpecializationsFactoryImpl(router: router)
        let coordinator = SpecializationsCoordinatorImpl(router: router, factory: specializationsFactory)
        specializationCoordinator = coordinator
        coordinator.start()
    }
}

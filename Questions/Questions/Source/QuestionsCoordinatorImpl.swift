import NavigationKit
import UIKit

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
    private var specialtyCoordinator: SpecialtyCoordinator?

    public init(
        router: Router,
        factory: QuestionsOnboardingFactory
    ) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        questionsOnboardingScreen = factory.makeQuestionsOnboardingScreen(onSelectSpecialty: { [weak self] in
            self?.startSpecialtyFlow()
        })
    }

    public func getQuestionsOnboardingScreen() -> QuestionsOnboardingViewController? {
        if questionsOnboardingScreen == nil {
            start()
        }
        return questionsOnboardingScreen
    }

    private func startSpecialtyFlow() {
        let specialFactory = SpecialtyFactoryImpl()
        let coordinator = SpecialtyCoordinatorImpl(router: router, factory: specialFactory)
        specialtyCoordinator = coordinator
        coordinator.start()
    }
}

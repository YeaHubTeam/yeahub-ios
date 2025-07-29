import NavigationKit

public class QuestionsOnboardingFactoryImpl: QuestionsOnboardingFactory {

    public init() {}

    public func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator {
        QuestionsOnboardingCoordinatorImpl(router: router, factory: self)
    }

    public func makeQuestionsOnboardingScreen() -> QuestionsOnboardingViewController {
        QuestionsOnboardingViewController()
    }
}

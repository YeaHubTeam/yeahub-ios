import NavigationKit

public class QuestionsOnboardingFactoryImpl: QuestionsOnboardingFactory {

    public init() {}

    public func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator {
        QuestionsOnboardingCoordinatorImpl(router: router, factory: self)
    }

    public func makeQuestionsOnboardingScreen(onSelectSpecialty: @escaping () -> Void) -> QuestionsOnboardingViewController {
        return QuestionsOnboardingViewController(onSelectSpecialty: onSelectSpecialty)
    }
}

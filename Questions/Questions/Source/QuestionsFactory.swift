import NavigationKit

public protocol QuestionsOnboardingFactory {

    func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator
    func makeQuestionsOnboardingScreen(onSelectSpecializations: @escaping () -> Void) -> QuestionsOnboardingViewController
}

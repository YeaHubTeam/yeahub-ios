import NavigationKit

public protocol QuestionsOnboardingFactory {

    func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator
    func makeQuestionsOnboardingScreen(onSelectSpecialty: @escaping () -> Void) -> QuestionsOnboardingViewController
}

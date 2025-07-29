import NavigationKit
import Home
import Questions

protocol MainFactory {

    func makeTabBarScreen() -> TabBarScreen
    func makeHomeCoordinator(router: Router) -> HomeCoordinator
    func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator
}

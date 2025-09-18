import Collections
import NavigationKit
import Home
import Questions

protocol MainFactory {
    func makeHomeCoordinator(router: Router) -> HomeCoordinator
    func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator
    func makeCollectionsCoordinator(router: Router) -> CollectionsCoordinator
}

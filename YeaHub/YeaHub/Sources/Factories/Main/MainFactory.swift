import Collections
import NavigationKit
import Home
import Questions

protocol MainFactory {
    func makeProfileCoordinator(router: Router) -> ProfileCoordinator
    func makeHomeCoordinator(router: Router) -> HomeCoordinator
    func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator
    func makeCollectionsCoordinator(router: Router) -> CollectionsCoordinator
}

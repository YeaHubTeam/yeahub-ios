import Collections
import UIKit
import NavigationKit
import Home
import Questions

class MainFactoryImpl: MainFactory {
    func makeProfileCoordinator(router: Router) -> ProfileCoordinator {
        let coordinator = ProfileCoordinatorImpl(router: router, factory: ProfileFactoryImpl())
        return coordinator
    }
    
    func makeHomeCoordinator(router: Router) -> HomeCoordinator {
        let coordinator = Home.makeHomeCoordinator(router: router)
        return coordinator
    }
    
    func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator {
        let coordinator = Questions.makeQuestionsOnboardingCoordinator(router: router)
        return coordinator
    }
    
    func makeCollectionsCoordinator(router: Router) -> CollectionsCoordinator {
        Collections.makeCollectionsCoordinator(router: router)
    }
}

import UIKit
import NavigationKit
import Home
import Questions

class MainFactoryImpl: MainFactory {

    func makeHomeCoordinator(router: Router) -> HomeCoordinator {
        let coordinator = Home.makeHomeCoordinator(router: router)
        return coordinator
    }

    func makeQuestionsOnboardingCoordinator(router: Router) -> QuestionsOnboardingCoordinator {
        let coordinator = Questions.makeQuestionsOnboardingCoordinator(router: router)
        return coordinator
    }
}

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

    public init(
        router: Router,
        factory: QuestionsOnboardingFactory
    ) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        questionsOnboardingScreen = factory.makeQuestionsOnboardingScreen()
    }

    public func getQuestionsOnboardingScreen() -> QuestionsOnboardingViewController? {
        if questionsOnboardingScreen == nil {
            start()
        }
        return questionsOnboardingScreen
    }
}

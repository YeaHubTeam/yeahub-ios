import NavigationKit

public func makeQuestionsListCoordinator(router: Router) -> QuestionsListCoordinator {
    QuestionsListCoordinatorImpl(router: router, factory: QuestionsListFactoryImpl())
}

public final class QuestionsLisCoordinatorImpl: QuestionsListCoordinator {
    public var router: Router
    public var factory: QuestionsListFactory
    private var questionsListScreen: QuestionsListViewController?

    public init(router: Router, factory: QuestionsListFactory) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        questionsListScreen = factory.makeQuestionsListScreen()

        router.push(questionsListScreen, animated: true)
    }

    public func getQuestionsListScreen() -> QuestionsListViewController? {
        if questionsListScreen == nil {
            start()
        }
        return questionsListScreen
    }
}

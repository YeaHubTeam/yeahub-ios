import NavigationKit

public final class QuestionsCoordinatorImpl: QuestionsCoordinator {
    public var router: Router
    public var factory: QuestionsFactory
    private var questionsScreen: QuestionsViewController?

    public init(router: Router, factory: QuestionsFactory) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        questionsScreen = factory.makeQuestionsScreen()
        router.push(questionsScreen, animated: true)
    }

    public func startSomeFlow() {
    }
}

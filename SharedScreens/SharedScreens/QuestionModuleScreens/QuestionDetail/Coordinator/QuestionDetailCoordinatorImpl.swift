import NavigationKit

public final class QuestionDetailCoordinatorImpl: QuestionDetailCoordinator {
    
    let router: Router
    let factory: QuestionDetailFactory
    private var viewController: QuestionDetailViewController?

    init(router: Router, factory: QuestionDetailFactory) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        router.push(viewController, animated: true)
    }

    func start(question: QuestionsModel) {
        viewController = factory.makeQuestionDetailScreen(question: question)
        start()
    }
}

import NavigationKit

public final class QuestionDetailCoordinatorImpl: QuestionDetailCoordinator {
    
    let router: Router
    let factory: QuestionDetailFactory

    init(router: Router, factory: QuestionDetailFactory) {
        self.router = router
        self.factory = factory
    }

    func start(question: QuestionDetailModel) {
        let viewController = factory.makeQuestionDetailScreen(question: question)
        router.push(viewController, animated: true)
    }
}

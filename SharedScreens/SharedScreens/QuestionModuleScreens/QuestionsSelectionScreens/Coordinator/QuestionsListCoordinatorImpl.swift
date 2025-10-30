import NavigationKit

public final class QuestionsListCoordinatorImpl: QuestionsListCoordinator {
    public var router: Router
    public var factory: QuestionsListFactory
    private var questionsListScreen: QuestionsListViewController?
    private var currentSpecializations: [Specialization] = []

    public init(
        router: Router,
        factory: QuestionsListFactory
    ) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        assertionFailure("Use start(with specializationId:specializationTitle:) method instead")
    }

    public func start(with specializations: [Specialization]) {
        guard
            !specializations.isEmpty
        else {
            return
        }
        currentSpecializations = specializations
        questionsListScreen = factory.makeQuestionsListScreen(specializations: specializations)
        router.push(questionsListScreen, animated: true)
    }


    public func getQuestionsListScreen() -> QuestionsListViewController? {
        if questionsListScreen == nil && !currentSpecializations.isEmpty {
            questionsListScreen = factory.makeQuestionsListScreen(specializations: currentSpecializations)
        }
        return questionsListScreen
    }

    public func startQuestionDetailFlow(question: QuestionsModel) {
        let factory = QuestionDetailFactoryImpl()
        let coordinator = QuestionDetailCoordinatorImpl(router: router, factory: factory)
        coordinator.start(question: question)
    }
}

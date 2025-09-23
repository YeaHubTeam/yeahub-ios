import NavigationKit

public final class QuestionsListCoordinatorImpl: QuestionsListCoordinator {
    public var router: Router
    public var factory: QuestionsListFactory
    private var questionsListScreen: QuestionsListViewController?
    private var currentSpecializationId: Int = 0
    private var currentSpecializationTitle: String = ""

    public init(router: Router, factory: QuestionsListFactory) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        assertionFailure("Use start(with specializationId:specializationTitle:) method instead")
    }

    public func start(with specializationId: Int, specializationTitle: String) {
        guard specializationId > 0 && !specializationTitle.isEmpty else {
            return
        }
        
        currentSpecializationId = specializationId
        currentSpecializationTitle = specializationTitle
        questionsListScreen = factory.makeQuestionsListScreen(specializationId: specializationId, specializationTitle: specializationTitle)
        router.push(questionsListScreen, animated: true)
    }

    public func getQuestionsListScreen() -> QuestionsListViewController? {
        if questionsListScreen == nil && currentSpecializationId > 0 && !currentSpecializationTitle.isEmpty {
            questionsListScreen = factory.makeQuestionsListScreen(specializationId: currentSpecializationId, specializationTitle: currentSpecializationTitle)
        }
        return questionsListScreen
    }

    public func startQuestionDetailFlow(question: QuestionsModel) {
        let factory = QuestionDetailFactoryImpl()
        let coordinator = QuestionDetailCoordinatorImpl(router: router, factory: factory)
        coordinator.start(question: question)
    }
}

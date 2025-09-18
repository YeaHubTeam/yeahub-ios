import NavigationKit

public protocol QuestionsListCoordinator: Coordinator {
    var factory: QuestionsListFactory { get }
    
    func start(with specializationId: Int, specializationTitle: String)
    func getQuestionsListScreen() -> QuestionsListViewController?
    func startQuestionDetailFlow(question: QuestionsModel)
}

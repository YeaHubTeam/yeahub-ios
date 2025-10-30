import NavigationKit

public protocol QuestionsListCoordinator: Coordinator {
    var factory: QuestionsListFactory { get }
    
    func start(with specializations: [Specialization])
    func getQuestionsListScreen() -> QuestionsListViewController?
    func startQuestionDetailFlow(question: QuestionsModel)
}

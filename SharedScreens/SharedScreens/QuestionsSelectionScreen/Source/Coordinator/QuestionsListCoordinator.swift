import NavigationKit

public protocol QuestionsListCoordinator: Coordinator {
    var factory: QuestionsListFactory { get }
    
    
    func start(with specializationId: Int, specializationTitle: String)
    func startQuestionDetailFlow(model: QuestionsModel)
    func getQuestionsListScreen() -> QuestionsListViewController?
}

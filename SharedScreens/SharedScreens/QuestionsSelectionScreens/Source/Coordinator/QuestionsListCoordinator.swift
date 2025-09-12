import NavigationKit

public protocol QuestionsListCoordinator: Coordinator {
    var factory: QuestionsListFactory { get }
    
    func start()
    func getQuestionsListScreen() -> QuestionsListViewController?
}

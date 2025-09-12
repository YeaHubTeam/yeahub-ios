import NavigationKit

public protocol QuestionsCoordinator: Coordinator {
    var factory: QuestionsFactory { get }

    func start()
    func startSomeFlow()
}

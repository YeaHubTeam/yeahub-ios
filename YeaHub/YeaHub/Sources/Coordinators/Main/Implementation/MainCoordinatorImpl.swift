import SwiftUI

class MainCoordinatorImpl: MainCoordinator, ChildCoordinatorManaging, NavigationDelegate, ObservableObject {
    var childCoordinators: [CoordinatorProtocol] = []
    @Published var selectedTab: Int = 0

    func start() {
        setupCoordinators()
    }

    private func setupCoordinators() {
        // TODO: Replace with actual module coordinators
        // when HomeModule, QuestionsModule, QuestionsCollectionsModule are created
        // For now, create simple placeholder coordinators
        let homeCoordinator = PlaceholderCoordinator(
            title: "Home",
            backgroundColor: .blue,
            navigationDelegate: self
        )

        let questionsCoordinator = PlaceholderCoordinator(
            title: "Questions",
            backgroundColor: .green,
            navigationDelegate: self
        )

        let collectionsCoordinator = PlaceholderCoordinator(
            title: "Collections",
            backgroundColor: .orange,
            navigationDelegate: self
        )

        // Add as child coordinators
        addChild(homeCoordinator)
        addChild(questionsCoordinator)
        addChild(collectionsCoordinator)

        // Start coordinators
        homeCoordinator.start()
        questionsCoordinator.start()
        collectionsCoordinator.start()
    }

    func finish() {
        // Cleanup logic if needed
    }

    // MARK: - NavigationDelegate
    func handle(navigationRequest: NavigationRequest) {
        switch navigationRequest {
        case .home:
            selectedTab = 0
        case .questions:
            selectedTab = 1
        case .questionsCollections:
            selectedTab = 2
        case .custom(let action, let params):
            // Handle custom navigation requests as needed
            print("Custom navigation: \(action), params: \(params)")
        }
    }
}

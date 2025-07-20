import SwiftUI

class PlaceholderCoordinator: CoordinatorProtocol, ObservableObject {
    private let title: String
    private let backgroundColor: Color
    private weak var navigationDelegate: NavigationDelegate?

    init(
        title: String,
        backgroundColor: Color,
        navigationDelegate: NavigationDelegate?
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.navigationDelegate = navigationDelegate
    }

    func start() {
        // Coordinator is ready, SwiftUI view will be created when needed
    }

    func finish() {
        // Cleanup logic if needed
    }

    func makeView() -> some View {
        PlaceholderView(title: title, backgroundColor: backgroundColor)
    }
}

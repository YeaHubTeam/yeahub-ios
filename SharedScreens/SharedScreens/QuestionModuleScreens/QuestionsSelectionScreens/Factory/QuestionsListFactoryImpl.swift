import Foundation
import NavigationKit
import Networking

public final class QuestionsListFactoryImpl: QuestionsListFactory {
    let router: Router
    public init(router: Router) {
        self.router = router
    }

    public func makeQuestionsListScreen(specializationId: Int, specializationTitle: String) -> QuestionsListViewController {
        let client = UrlSessionHttpClient()
        let repository = QuestionsRepository(client: client)
        let coordinator = QuestionsListCoordinatorImpl(router: router, factory: self)
        let viewModel = QuestionsViewModel(repository: repository, specializationId: specializationId, coordinator: coordinator)
        return QuestionsListViewController(viewModel: viewModel, specializationTitle: specializationTitle)
    }
}

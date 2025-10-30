import Foundation
import NavigationKit
import Networking

public final class QuestionsListFactoryImpl: QuestionsListFactory {

    let router: Router
    public init(router: Router) {
        self.router = router
    }

    public func makeQuestionsListScreen(specializations: [Specialization]) -> QuestionsListViewController {
        let client = UrlSessionHttpClient()
        let repository = QuestionsRepository(client: client)
        let coordinator = QuestionsListCoordinatorImpl(router: router, factory: self)
        let viewModel = QuestionsViewModel(repository: repository, specializations: specializations, coordinator: coordinator)
        let specializationTitle = specializations.map { $0.title }.joined(separator: ", ")
        return QuestionsListViewController(viewModel: viewModel, specializationTitle: specializationTitle)
    }
}

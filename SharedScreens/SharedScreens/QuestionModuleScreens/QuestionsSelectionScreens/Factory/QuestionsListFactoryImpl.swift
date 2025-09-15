import Foundation
import NavigationKit
import Networking

public final class QuestionsListFactoryImpl: QuestionsListFactory {
    public init() {}

    public func makeQuestionsListScreen(specializationId: Int, specializationTitle: String) -> QuestionsListViewController {
        let client = UrlSessionHttpClient()
        let repository = QuestionsRepository(client: client)
        let viewModel = QuestionsViewModel(repository: repository, specializationId: specializationId)
        return QuestionsListViewController(viewModel: viewModel, specializationTitle: specializationTitle)
    }
}

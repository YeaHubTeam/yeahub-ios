import Foundation
import NavigationKit
import Networking

public final class QuestionsListFactoryImpl: QuestionsListFactory {
    public init() {}

    public func makeQuestionsListScreen() -> QuestionsListViewController {
        let client = UrlSessionHttpClient()
        let repositoty = QuestionsRepository(client: client)
        let viewModel = QuestionsViewModel(repository: repositoty)
        return QuestionsListViewController(viewModel: viewModel)
    }
}

import Foundation
import NavigationKit
import Networking

public final class QuestionFactoryImpl: QuestionFactory {
    public init() {}

    public func makeQuestionScreen() -> QuestionViewController {
        let client = UrlSessionHttpClient()
        let repositoty = QuestionsRepository(client: client)
        let viewModel = QuestionsViewModel(repository: repositoty)
        return QuestionViewController(viewModel: viewModel)
    }
}

import Foundation
import Networking

protocol QuestionsRepositoryProtocol {
    func fetchQuestions() async throws -> [QuestionsModel]
}

final class QuestionsRepository: QuestionsRepositoryProtocol {
    private let client: HttpClient

    init(client: HttpClient) {
        self.client = client
    }

    func fetchQuestions() async throws -> [QuestionsModel] {
        let request = GetQuestionsRequest()
        let response = try await client.dataTask(request)

        guard response.statusCode.isValid else {
            if response.statusCode == .notFound {
                throw HttpError.notFound(response)
            } else {
                throw HttpError.invalidStatusCode(response)
            }
        }

        let decoded = try JSONDecoder().decode(QuestionsResponse.self, from: response.data)
        return decoded.data
    }
}

import Foundation
import Networking

final class SpecializationsRepository: SpecializationsRepositoryProtocol {
    private let client: HttpClient

    init(client: HttpClient) {
        self.client = client
    }

    func fetchSpecializations() async throws -> [Specialization] {
        let request = GetSpecializationsRequest()
        let response = try await client.dataTask(request)

        if response.statusCode == .notFound {
            throw HttpError.notFound(response)
        } else if !response.statusCode.isValid {
            throw HttpError.invalidStatusCode(response)
        }

        let decoded = try JSONDecoder().decode(SpecializationsResponse.self, from: response.data)
        return decoded.data
    }
}

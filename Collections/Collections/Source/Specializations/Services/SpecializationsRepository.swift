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
        let decoded = try JSONDecoder().decode(SpecializationsResponse.self, from: response.data)
        return decoded.data
    }
}

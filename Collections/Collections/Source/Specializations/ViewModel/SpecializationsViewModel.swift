import Combine
import Foundation
import Networking

public final class SpecializationsViewModel: ObservableObject {
    private let repository: SpecializationsRepositoryProtocol

    @Published var specializations: [Specialization] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    init(repository: SpecializationsRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor
    func loadSpecializations() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await repository.fetchSpecializations()
            specializations = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

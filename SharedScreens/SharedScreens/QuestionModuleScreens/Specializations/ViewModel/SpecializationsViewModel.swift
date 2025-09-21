import Combine
import CommonUI
import Foundation
import Networking

public final class SpecializationsViewModel: ObservableObject {
    private let repository: SpecializationsRepositoryProtocol
    private let coordinator: SpecializationsCoordinator

    @Published var specializations: [Specialization] = []
    @Published var viewState = Constants.loading

    init(repository: SpecializationsRepositoryProtocol, coordinator: SpecializationsCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }

    func loadSpecializations() async {
        guard specializations.isEmpty else {
            return
        }
        
        do {
            let result = try await repository.fetchSpecializations()
            try Task.checkCancellation()
            await MainActor.run {
                specializations = result
                viewState = .success
            }
        } catch let error as HttpError {
            switch error {
            case .notFound:
                await MainActor.run {
                    viewState = Constants.error404
                }
            default:
                await MainActor.run {
                    viewState = .commonError(title: error.localizedDescription)
                }
            }
        } catch let error as URLError where error.code == .timedOut {
            await MainActor.run {
                viewState = .requestTimedOut
            }
        } catch {
            await MainActor.run {
                viewState = Constants.commonError
            }
        }
    }

    func passQuestionID(_ id: Int, _ specializationTitle: String) {
        coordinator.startQuestionFlow(id: id, specializationTitle: specializationTitle)
    }
}

private extension SpecializationsViewModel {
    enum Constants {
        static let loading: LoadingState = .loading(title: "Загрузка…")
        static let error404: LoadingState = .error404(title: "Специальности не найдены")
        static let commonError: LoadingState = .commonError(title: "Что-то пошло не так")
    }
}

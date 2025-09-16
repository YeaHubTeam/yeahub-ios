import Combine
import CommonUI
import Foundation
import Networking

public final class SpecializationsViewModel: ObservableObject {
    private let repository: SpecializationsRepositoryProtocol
    private let coordinator: SpecializationsCoordinator

    @Published var specializations: [Specialization] = []
    @Published var viewState = Constants.loading

    private var loadTask: Task<Void, Never>?

    init(repository: SpecializationsRepositoryProtocol, coordinator: SpecializationsCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }

    func cancelLoading() {
        loadTask?.cancel()
    }

    @MainActor
    func loadSpecializations() {
        cancelLoading()
        loadTask = Task {
            viewState = Constants.loading

            do {
                let result = try await repository.fetchSpecializations()
                try Task.checkCancellation()
                specializations = result
                viewState = .success
            } catch let error as HttpError {
                switch error {
                case .notFound:
                    viewState = Constants.error404
                default:
                    viewState = .commonError(title: error.localizedDescription)
                }
            } catch let error as URLError where error.code == .timedOut {
                viewState = .requestTimedOut
            } catch {
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

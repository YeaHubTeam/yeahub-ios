import Combine
import CommonUI
import Foundation
import Networking

public final class SpecializationsViewModel: ObservableObject {
    private let repository: SpecializationsRepositoryProtocol
    private let coordinator: SpecializationsCoordinator

    @Published var specializations: [Specialization] = []
    @Published var viewState: LoadingState = .loading(title: "Загрузка…")

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
            viewState = .loading(title: "Загрузка…")

            do {
                let result = try await repository.fetchSpecializations()
                try Task.checkCancellation()
                specializations = result
                viewState = .success
            } catch let error as HttpError {
                switch error {
                case .notFound:
                    viewState = .error404(title: "Специальности не найдены")
                default:
                    viewState = .commonError(title: error.localizedDescription)
                }
            } catch let error as URLError where error.code == .timedOut {
                viewState = .requestTimedOut
            } catch {
                viewState = .commonError(title: "Что-то пошло не так")
            }
        }
    }

    func passQuestionID(_ id: Int) {
        coordinator.startQuestionFlow(id: id)
    }
}

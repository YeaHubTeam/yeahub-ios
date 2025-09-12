import Combine
import CommonUI
import Foundation
import Networking

public final class SpecializationsViewModel: ObservableObject {
    private let repository: SpecializationsRepositoryProtocol

    @Published var specializations: [Specialization] = []
    @Published var viewState: LoadingState = .loading(title: "Загрузка…")

    private var loadTask: Task<Void, Never>?

    init(repository: SpecializationsRepositoryProtocol) {
        self.repository = repository
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
}

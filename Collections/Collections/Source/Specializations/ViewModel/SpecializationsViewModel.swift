import Combine
import CommonUI
import Foundation
import Networking

public final class SpecializationsViewModel: ObservableObject {
    private let repository: SpecializationsRepositoryProtocol

    @Published var specializations: [Specialization] = []
    @Published var viewState: LoadingState = .loading(title: "Загрузка…")

    init(repository: SpecializationsRepositoryProtocol) {
        self.repository = repository
    }

    func loadSpecializations() async {
        do {
            let result = try await repository.fetchSpecializations()
            await MainActor.run {
                specializations = result
                viewState = .success
            }
        } catch let error as HttpError {
            switch error {
            case .notFound:
                await MainActor.run {
                    viewState = .error404(title: "Специальности не найдены")
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
                viewState = .commonError(title: "Что-то пошло не так")
            }
        }
    }

    func isNeedToLoad() {
        if specializations.isEmpty {
            Task {
                await loadSpecializations()
            }
        }
    }
}

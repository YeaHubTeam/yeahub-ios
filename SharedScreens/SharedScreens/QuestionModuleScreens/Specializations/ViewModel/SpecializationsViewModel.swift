import Combine
import CommonUI
import Foundation
import Networking

public final class SpecializationsViewModel: ObservableObject {
    private let repository: SpecializationsRepositoryProtocol
    private let coordinator: SpecializationsCoordinator
    
    @Published public var taggedItems: [(tag: TagItem, specialization: Specialization)] = []
    @Published public var viewState = Constants.loading
    @Published public var searchText: String = ""
    
    public init(
        repository: SpecializationsRepositoryProtocol,
        coordinator: SpecializationsCoordinator
    ) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    var filterTaggedItems: [(tag: TagItem, specialization: Specialization)] {
        let filter = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard
            !filter.isEmpty
        else {
            return taggedItems
        }
        
        let lowercased = filter.lowercased()
        return taggedItems.filter {
            $0.specialization.title.lowercased().contains(lowercased) || $0.specialization.description.lowercased().contains(lowercased)
        }
    }
    
    public func loadSpecializations() async {
        guard
            taggedItems.isEmpty
        else {
            return
        }
        do {
            let result = try await repository.fetchSpecializations()
            try Task.checkCancellation()
            await MainActor.run {
                mapSpecializationsToTags(result)
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
    
    public func passSpecialization(_ specialization: Specialization) {
        coordinator.startQuestionFlow(id: specialization.id, specializationTitle: specialization.title)
    }
    
    private func mapSpecializationsToTags(_ specializations: [Specialization]) {
        taggedItems = specializations.map { specialization in
            let tag = TagItem(id: specialization.id, title: specialization.title, icon: nil)
            return (tag: tag, specialization: specialization)
        }
    }
}

private extension SpecializationsViewModel {
    enum Constants {
        static let loading: LoadingState = .loading(title: "Загрузка…")
        static let error404: LoadingState = .error404(title: "Специальности не найдены")
        static let commonError: LoadingState = .commonError(title: "Что-то пошло не так")
    }
}

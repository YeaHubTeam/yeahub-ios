import Combine
import CommonUI
import Foundation
import Networking

public final class QuestionsViewModel: ObservableObject {
    private let repository: QuestionsRepository
    private let specializations: [Specialization]
    private let coordinator: QuestionsListCoordinator
    
    @Published var questionsSpecialization: [Int: [QuestionsModel]] = [:]
    @Published var viewState = Constants.loading
    
    private var loadTask: Task<Void, Never>?
    
    
    init(
        repository: QuestionsRepository,
        specializations: [Specialization],
        coordinator: QuestionsListCoordinator
    ) {
        self.repository = repository
        self.specializations = specializations
        self.coordinator = coordinator
    }
    
    public var selectedSpecializations: [Specialization] {
        specializations
    }
    
    func cancelLoading() {
        loadTask?.cancel()
    }
    
    @MainActor
    func loadQuestions() {
        cancelLoading()
        loadTask = Task {
            viewState = Constants.loading
            do {
                var loadedQuestion: [Int: [QuestionsModel]] = [:]
                for specialization in specializations {
                    let result = try await repository.fetchQuestions(for: specialization.id)
                    try Task.checkCancellation()
                    loadedQuestion[specialization.id] = result
                }
                questionsSpecialization = loadedQuestion
                viewState = .success
            } catch let error as HttpError {
                switch error {
                case .notFound:
                    viewState = Constants.error404
                default:
                    viewState = .commonError(title: error.localizedDescription)
                }
            } catch let error {
                viewState = Constants.commonError
            }
        }
    }
    
    @MainActor
    func loadQuestionsIfNeeded() {
        if questionsSpecialization.isEmpty {
            loadQuestions()
        }
    }
    
    func passQuestionModel(question: QuestionsModel) {
        coordinator.startQuestionDetailFlow(question: question)
    }
}

private extension QuestionsViewModel {
    enum Constants {
        static let loading: LoadingState = .loading(title: "Загрузка…")
        static let error404: LoadingState = .error404(title: "Вопросы не найдены")
        static let commonError: LoadingState = .commonError(title: "Что-то пошло не так")
    }
}

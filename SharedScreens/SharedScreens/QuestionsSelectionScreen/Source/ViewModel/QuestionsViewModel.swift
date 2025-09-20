import Combine
import CommonUI
import Foundation
import Networking

public final class QuestionsViewModel: ObservableObject {
    private let repository: QuestionsRepository
    private let specializationId: Int
    private let coordinator: QuestionsListCoordinator

    @Published var questions: [QuestionsModel] = []
    @Published var viewState: LoadingState = Constants.loading

    private var loadTask: Task<Void, Never>?

    init(repository: QuestionsRepository, specializationId: Int, coordinator: QuestionsListCoordinator) {
        self.repository = repository
        self.specializationId = specializationId
        self.coordinator = coordinator
    }

    func cancelLoading() {
        loadTask?.cancel()
    }
    
    func passQuestionModel(for question: QuestionsModel) {
        coordinator.startQuestionDetailFlow(model: question)
    }

    @MainActor
    func loadQuestions() {
        cancelLoading()
        loadTask = Task {
            viewState = Constants.loading

            do {
                let result = try await repository.fetchQuestions(for: specializationId)
                try Task.checkCancellation()
                questions = result
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
        if questions.isEmpty {
            loadQuestions()
        }
    }
}

private extension QuestionsViewModel {
    enum Constants {
        static let loading: LoadingState = .loading(title: "Загрузка…")
        static let error404: LoadingState = .error404(title: "Вопросы не найдены")
        static let commonError: LoadingState = .commonError(title: "Что-то пошло не так")
    }
}

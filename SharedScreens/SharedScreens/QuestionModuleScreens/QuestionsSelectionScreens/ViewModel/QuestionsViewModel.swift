import Combine
import CommonUI
import Foundation
import Networking

public final class QuestionsViewModel: ObservableObject {
    private let repository: QuestionsRepository
    private let specializationId: Int

    @Published var questions: [QuestionsModel] = []
    @Published var viewState: LoadingState = .loading(title: "Загрузка…")

    private var loadTask: Task<Void, Never>?

    init(repository: QuestionsRepository, specializationId: Int) {
        self.repository = repository
        self.specializationId = specializationId
    }

    func cancelLoading() {
        loadTask?.cancel()
    }

    @MainActor
    func loadQuestions() {
        cancelLoading()
        loadTask = Task {
            viewState = .loading(title: "Загрузка…")

            do {
                let result = try await repository.fetchQuestions(for: specializationId)
                try Task.checkCancellation()
                questions = result
                viewState = .success
            } catch let error as HttpError {
                switch error {
                case .notFound:
                    viewState = .error404(title: "Вопросы не найдены")
                default:
                    viewState = .commonError(title: error.localizedDescription)
                }
            } catch let error {
                print (type(of: error))
                viewState = .commonError(title: "Что-то пошло не так")
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

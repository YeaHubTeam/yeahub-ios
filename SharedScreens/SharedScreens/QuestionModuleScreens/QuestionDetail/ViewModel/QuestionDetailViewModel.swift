import Combine

public final class QuestionDetailViewModel: ObservableObject {
    let question: QuestionsModel

    init(question: QuestionsModel) {
        self.question = question
    }
}

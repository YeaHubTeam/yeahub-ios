import Combine

public final class QuestionDetailViewModel: ObservableObject {
    let question: QuestionDetailModel

    init(question: QuestionDetailModel) {
        self.question = question
    }
}

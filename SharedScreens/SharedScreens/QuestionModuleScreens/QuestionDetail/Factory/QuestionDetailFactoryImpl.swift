final class QuestionDetailFactoryImpl: QuestionDetailFactory {
    func makeQuestionDetailScreen(question: QuestionsModel) -> QuestionDetailViewController {
        let viewModel = QuestionDetailViewModel(question: question)
        return QuestionDetailViewController(viewModel: viewModel)
    }
}

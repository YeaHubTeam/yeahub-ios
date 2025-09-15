final class QuestionDetailFactoryImpl: QuestionDetailFactory {
    func makeQuestionDetailScreen(question: QuestionDetailModel) -> QuestionDetailViewController {
        let viewModel = QuestionDetailViewModel(question: question)
        return QuestionDetailViewController(viewModel: viewModel)
    }
}

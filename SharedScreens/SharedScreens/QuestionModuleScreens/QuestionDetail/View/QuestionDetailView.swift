import CommonUI
import SwiftUI

struct QuestionDetailView: View {
    @ObservedObject var viewModel: QuestionDetailViewModel

    var body: some View {
        ScrollView {
            YHBaseCell(state: .questionDescription(title: viewModel.question.title, text: viewModel.question.description ?? ""))

            YHBaseCell(state: .answer(title: Constants.shortAnswerTitle, text: viewModel.question.shortAnswer ?? ""))

            YHBaseCell(state: .answer(title: Constants.longAnswerTitle, text: viewModel.question.longAnswer ?? ""))
        }
    }
}

private extension QuestionDetailView {
    enum Constants {
        static let shortAnswerTitle = "Краткий ответ"
        static let longAnswerTitle = "Развернутый ответ"
    }
}

#Preview {
    QuestionDetailView(viewModel: QuestionDetailViewModel(
        question: QuestionsModel(id: 12, title: "123", description: "456", shortAnswer: "789", longAnswer: "1011")))
}

import CommonUI
import SwiftUI

struct QuestionDetailView: View {
    var viewModel: QuestionDetailViewModel

    var body: some View {
        ScrollView {
            YHBaseCell(state: .questionDescription(title: viewModel.question.title, text: viewModel.question.description ?? ""))

            YHBaseCell(state: .answer(title: Constants.shortAnswerTitle, text: viewModel.formattedShortAnswer))

            YHBaseCell(state: .answer(title: Constants.longAnswerTitle, text: viewModel.formattedLongAnswer))
        }
        .padding(.bottom, Constants.buttomScrollViewPadding)
    }
}

private extension QuestionDetailView {
    enum Constants {
        static let shortAnswerTitle = "Краткий ответ"
        static let longAnswerTitle = "Развернутый ответ"
        
        static let buttomScrollViewPadding: CGFloat = 32
    }
}

#Preview {
    QuestionDetailView(viewModel: QuestionDetailViewModel(
        question: QuestionsModel(id: 12, title: "123", description: "456", shortAnswer: "789", longAnswer: "1011")))
}

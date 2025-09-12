import CommonUI
import SwiftUI

struct QuestionsListView: View {
    @ObservedObject var viewModel: QuestionsViewModel

    var body: some View {
        YHLoader(state: viewModel.viewState) {
            getCurrentView()
        }
        .task {
            viewModel.loadQuestions()
        }
        .animation(.easeInOut, value: viewModel.viewState)
        .onDisappear {
            viewModel.cancelLoading()
        }
    }

    private func getCurrentView() -> some View {
        return VStack(alignment: .leading, spacing: Constants.headerSpacing) {
            Text(Constants.header)
                .font(Constants.headerFont)
                .foregroundStyle(Constants.headerColor)
                .padding(.horizontal, Constants.headerHorizontalPadding)
                .padding(.top, Constants.headerTopPadding)

            ScrollView {
                LazyVStack(spacing: Constants.defaultSpacing) {
                    ForEach(viewModel.questions) { question in
                        ZStack {
                            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                .foregroundStyle(Constants.roundedRectangleColor)
                                .frame(height: Constants.roundedRectangleHeight)
                                .padding(.horizontal, Constants.roundedRectangleHorizontalPadding)
                                .defaultShadow()

                            Text(question.title)
                                .font(Constants.questionFont)
                                .foregroundStyle(Constants.questionColor)
                        }
                    }
                }
                .padding(.vertical, Constants.defaultPadding)
            }
        }
        .background(Constants.background)
    }
}

private extension QuestionsListView {
    enum Constants {
        static let header = "IT-специальность"

        static let headerSpacing: CGFloat = 10
        static let headerFont: Font = .manrope(.semibold, size: 20)
        static let headerColor: Color = .black900
        static let headerHorizontalPadding: CGFloat = 16
        static let headerTopPadding: CGFloat = 24

        static let defaultSpacing: CGFloat = 8
        static let defaultPadding: CGFloat = 16
        static let background: Color = .black10

        static let cornerRadius: CGFloat = 8
        static let roundedRectangleColor: Color = .white
        static let roundedRectangleHeight: CGFloat = 64
        static let roundedRectangleHorizontalPadding: CGFloat = 16

        static let questionFont: Font = .manrope(.medium, size: 16)
        static let questionColor: Color = .black900
    }
}

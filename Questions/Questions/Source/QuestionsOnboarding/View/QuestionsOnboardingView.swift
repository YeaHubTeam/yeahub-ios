import SwiftUI
import CommonUI

struct QuestionsOnboardingView: View {
    public var onSelectSpecializations: () -> Void

    var body: some View {
        ZStack {
            Color.black10
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: Constants.verticalInset) {
                Text("База вопросов")
                    .foregroundStyle(Color.black900)
                    .font(.manrope(.semibold, size: 20))

                VStack(spacing: Constants.defaultInset) {

                    HStack(alignment: .top, spacing: Constants.Button.horizontalInset) {
                        CommonUIAssets.image("questionsIcon")
                            .frame(
                                width: Constants.questionsIconSize.width,
                                height: Constants.questionsIconSize.height
                            )
                        
                        Text("Сотни проверенных вопросов по специальностям Frontend, Backend, QA, DevOps, Data Analytics и другие. Прокачайте знания — от джуниора до синьора")
                            .foregroundStyle(Color.black900)
                            .font(.manrope(.medium, size: 16))
                    }
                    .padding(.horizontal, Constants.Button.horizontalInset)
                    .padding(.vertical, Constants.defaultInset)
                    .background(Color.white)
                    .cornerRadius(Constants.Button.cornerRadius)
                    
                    YHButton(title: "Выбрать специальность", action: onSelectSpecializations)
                    
                    Spacer()
                }
            }
            .padding(.top, Constants.topInset)
            .padding(.horizontal, Constants.defaultInset)
        }
    }
}

extension QuestionsOnboardingView {

    enum Constants {

        enum Button {
            static let horizontalInset: CGFloat = 12
            static let cornerRadius: CGFloat = 8
        }

        static let questionsIconSize: CGSize = CGSize(width: 80, height: 92)
        static let defaultInset: CGFloat = 16
        static let verticalInset: CGFloat = 20
        static let topInset: CGFloat = 24
    }
}

#Preview {
    QuestionsOnboardingView(onSelectSpecializations: {})
}

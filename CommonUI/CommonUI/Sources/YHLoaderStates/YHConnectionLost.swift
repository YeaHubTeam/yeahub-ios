import SwiftUI

struct YHConnectionLost: View {
    var refresh: () -> Void

    var body: some View {
        VStack(spacing: Constants.mainVStackSpacing) {
            CommonUIAssets.image(Constants.meerkatsImage)

            VStack(spacing: Constants.errorTextSpacing) {
                Text(Constants.errorTitle)
                    .font(Constants.errorTitleFont)
                    .foregroundColor(.textBlack)

                Text(Constants.errorMessage)
                    .font(Constants.errorMessageFont)
                    .foregroundColor(.black700)
                    .multilineTextAlignment(.center)
            }

            YHButton(title: Constants.buttonTitle) {
                refresh()
            }
            .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
        }
        .padding(Constants.inset)
        .frame(width: Constants.backgroundWidth)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.pureWhite)
                .defaultShadow()
        )
    }

}

// MARK: - Constsnts
private extension YHConnectionLost {
    enum Constants {
        static let backgroundWidth: CGFloat = 358
        static let inset: CGFloat = 40
        static let cornerRadius: CGFloat = 12
        static let mainVStackSpacing: CGFloat = 24
        static let errorTextSpacing: CGFloat = 8


        static let errorTitle = "Нет соединения"
        static let errorMessage = "Проверьте сеть и обновите страницу."
        static let errorTitleFont: Font = .manrope(.semibold, size: 18)
        static let errorMessageFont: Font = .manrope(.medium, size: 16)

        static let buttonTitle = "Обновить"
        static let buttonWidth: CGFloat = 170
        static let buttonHeight: CGFloat = 48

        static let meerkatsImage = "connectionLost"
    }
}

#Preview {
    YHConnectionLost(refresh: {})
}


import SwiftUI

struct YHError404: View {
    @Environment(\.dismiss) var dismiss
    let title: String

    var body: some View {
        VStack {
            HStack(spacing: Constants.hStackSpacing) {
                Text(Constants.errorTitle)
                    .font(.manrope(.bold, size: Constants.errorTitleFontSize))
                    .foregroundColor(.textBlack)

                CommonUIAssets.image(Constants.magnifierImageName)

                Text(Constants.errorTitle)
                    .font(.manrope(.bold, size: Constants.errorTitleFontSize))
                    .foregroundColor(.textBlack)
            }

            VStack(spacing: Constants.vStackSpacing) {
                Text(title)
                    .font(.manrope(.medium, size: Constants.errorTextFontSize))
                    .foregroundColor(.black700)

                YHButton(title: Constants.buttonTitle) {
                    dismiss()
                }
                .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
            }
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

// MARK: - Constants
private extension YHError404 {
    enum Constants {
        static let backgroundWidth: CGFloat = 358
        static let inset: CGFloat = 40
        static let cornerRadius: CGFloat = 12
        static let hStackSpacing: CGFloat = 0
        static let vStackSpacing: CGFloat = 24


        static let errorTitle = "4"
        static let errorTitleFontSize: CGFloat = 72
        static let errorTextFontSize: CGFloat = 16

        static let buttonTitle = "Назад"
        static let buttonWidth: CGFloat = 170
        static let buttonHeight: CGFloat = 48

        static let magnifierImageName = "magnifier"
    }
}

#Preview {
    YHError404(title: "Страница не найдена")
}

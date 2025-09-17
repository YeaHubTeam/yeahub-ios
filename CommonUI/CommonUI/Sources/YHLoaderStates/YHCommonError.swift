import SwiftUI

struct YHCommonError: View {
    @Environment(\.dismiss) var dismiss
    var title: String
    
    var body: some View {
        VStack(spacing: Constants.defaultSpacing) {
            VStack(spacing: Constants.errorSpacing) {
                Text(Constants.errorTitle)
                    .font(.manrope(.medium, size: Constants.errorTitleFontSize))
                    .foregroundColor(.textBlack)
                
                Text(title)
                    .font(.manrope(.medium, size: Constants.errorTextFontSize))
                    .foregroundColor(.black700)
            }
            
            YHButton(state: .primaryEnabled, title: Constants.buttonTitle) {
                dismiss()
            }
            .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
        }
        .padding(Constants.inset)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.pureWhite)
                .defaultShadow()
        )
        .padding(Constants.offset)
    }
}

// MARK: - Constants
private extension YHCommonError {
    enum Constants {
        static let defaultSpacing: CGFloat = 16
        static let errorSpacing: CGFloat = 4
        static let cornerRadius: CGFloat = 12
        static let inset: CGFloat = 16
        static let offset: CGFloat = 94
        
        static let errorTitle = "УПС!"
        static let errorTitleFontSize: CGFloat = 24
        static let errorTextFontSize: CGFloat = 16

        static let buttonTitle = "Назад"
        static let buttonWidth: CGFloat = 170
        static let buttonHeight: CGFloat = 48
    }
}

#Preview {
    YHCommonError(title: "Что-то пошло не так")
}

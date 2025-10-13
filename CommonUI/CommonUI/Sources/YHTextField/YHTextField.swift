import SwiftUI

public struct YHTextField: View {
    
    @Binding var password: String
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true
    
    private let placeholder: String
    
    public init(
        password: Binding<String>,
        placeholder: String = ""
    ) {
        self._password = password
        self.placeholder = placeholder
    }
    
    public var body: some View {
        HStack(spacing: Constants.hStackSpacing) {
            ZStack {
                SecureField(placeholder, text: $password)
                    .focused($isFocused)
                    .font(Constants.textFieldFont)
                    .foregroundColor(isFocused ? Color.black900 : Color.black300)
                    .textContentType(.password)
                    .submitLabel(.done)
                    .opacity(isSecure ? 1.0 : 0.0)
                
                TextField(placeholder, text: $password)
                    .focused($isFocused)
                    .font(Constants.textFieldFont)
                    .foregroundColor(isFocused ? Color.black900 : Color.black300)
                    .textContentType(.password)
                    .submitLabel(.done)
                    .opacity(isSecure ? 0.0 : 1.0)
            }
            
            Button(action: performToggle) {
                CommonUIAssets.image(isSecure ? Images.eyeSlash.rawValue : Images.eye.rawValue)
                    .foregroundColor(isFocused ? Color.black900 : Color.black300)
            }
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .frame(minHeight: Constants.height)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.pureWhite)
        )
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(isFocused ? Color.purple700 : Color.black50, lineWidth: 1)
        )
    }
    
    private func performToggle() {
        isSecure.toggle()
    }
}

private extension YHTextField {
    enum Constants {
        static let cornerRadius: CGFloat = 12
        static let height: CGFloat = 48
        static let hStackSpacing: CGFloat = 8
        static let horizontalPadding: CGFloat = 12
        static let textFieldFont: Font = .manrope(.regular, size: 16)
    }
}

private extension YHTextField {
    enum Images: String {
        case eye = "eyeIcon"
        case eyeSlash = "eyeSlashIcon"
    }
}

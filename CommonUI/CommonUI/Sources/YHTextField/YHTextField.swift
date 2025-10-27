import SwiftUI

public struct YHTextField: View {
    
    @Binding var text: String
    @Binding var isInvalid: Bool
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = false
    
    private let placeholder: String
    private let mode: Mode
    
    public init(
        text: Binding<String>,
        isInvalid: Binding<Bool> = .constant(false),
        placeholder: String = "",
        mode: Mode = .text
    ) {
        self._text = text
        self._isInvalid = isInvalid
        self.placeholder = placeholder
        self.mode = mode
        self._isSecure = State(initialValue: mode == .password ? true : false)
    }
    
    public var body: some View {
        HStack(spacing: Constants.hStackSpacing) {
            ZStack {
                SecureField(placeholder, text: $text)
                    .focused($isFocused)
                    .font(Constants.textFieldFont)
                    .foregroundColor(isFocused ? Color.black900 : Color.black300)
                    .textContentType(mode == .password ? .password : .none)
                    .submitLabel(.done)
                    .opacity(isSecure ? 1.0 : 0.0)
                
                TextField(placeholder, text: $text)
                    .focused($isFocused)
                    .font(Constants.textFieldFont)
                    .foregroundColor(isFocused ? Color.black900 : Color.black300)
                    .textContentType(mode == .password ? .password : .none)
                    .submitLabel(.done)
                    .opacity(isSecure ? 0.0 : 1.0)
            }
            
            if mode == .password {
                Button(action: performToggle) {
                    CommonUIAssets.image(isSecure ? Images.eyeSlash.rawValue : Images.eye.rawValue)
                        .foregroundColor(isFocused ? Color.black900 : Color.black300)
                }
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
                .stroke(borderColor, lineWidth: 1)
        )
    }
    
    private var borderColor: Color {
        if isInvalid {
            return Color.red700
        } else {
            return isFocused ? Color.purple700 : Color.black50
        }
    }
    
    private func performToggle() {
        isSecure.toggle()
    }
}

public extension YHTextField {
    enum Mode {
        case text
        case password
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

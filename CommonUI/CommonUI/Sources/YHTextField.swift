import SwiftUI

/// [Документация по YHTextField](https://wiki.yandex.ru/homepage/ce33d84eb842/dizajjn-sistemacommonui/komponent-yhtextfield/)

public struct YHTextField: View {
    
    public enum Mode {
        case common
        case password
    }
    
    private let title: String
    private let mode: Mode
    
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true

    public init(
        title: String = "Поиск",
        text: Binding<String>,
        mode: Mode = .common
    ) {
        self.title = title
        self._text = text
        self.mode = mode
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(isFocused ? Color.purple700 : Color.black50)
                .foregroundStyle(isFocused ? Color.black25 : Color.pureWhite)
                .frame(height: Constants.height)
                .padding(Constants.rectanglePadding)

            HStack(spacing: Constants.hStackSpacing) {
                switch mode {
                case .common:
                    CommonUIAssets.image(Constants.magniferIcon)
                        .foregroundColor(isFocused ? Color.black900 : Color.black300)

                    TextField(title, text: $text)
                        .focused($isFocused)
                        .font(Constants.textFieldFont)
                        .submitLabel(.search)
                    
                case .password:
                    ZStack {
                        SecureField(title, text: $text)
                            .focused($isFocused)
                            .font(Constants.textFieldFont)
                            .foregroundColor(isFocused ? Color.black900 : Color.black300)
                            .textContentType(.password)
                            .submitLabel(.done)
                            .opacity(isSecure ? 1.0 : 0.0)

                        TextField(title, text: $text)
                            .focused($isFocused)
                            .font(Constants.textFieldFont)
                            .foregroundColor(isFocused ? Color.black900 : Color.black300)
                            .textContentType(.password)
                            .submitLabel(.done)
                            .opacity(isSecure ? 0.0 : 1.0)
                    }

                    Button(action: performToggle) {
                        CommonUIAssets.image(isSecure ? Constants.eyeSlashIcon : Constants.eyeIcon)
                            .foregroundColor(isFocused ? Color.black900 : Color.black300)
                    }
                }
            }
            .padding(Constants.hStackPadding)
        }
    }
    
    private func performToggle() {
            isSecure.toggle()
    }
}

private extension YHTextField {
    enum Constants {
        static let cornerRadius: CGFloat = 12
        static let height: CGFloat = 48
        static let rectanglePadding: CGFloat = 16
        static let hStackSpacing: CGFloat = 16
        static let hStackPadding: CGFloat = 32
        static let textFieldFont: Font = .manrope(.regular, size: 16)
        static let magniferIcon = "magnifer"
        static let eyeIcon = "eyeIcon"
        static let eyeSlashIcon = "eyeSlashIcon"
    }
}

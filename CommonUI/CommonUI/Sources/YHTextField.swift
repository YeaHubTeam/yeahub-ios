import SwiftUI

/// [Документация по YHTextField](https://wiki.yandex.ru/homepage/ce33d84eb842/dizajjn-sistemacommonui/komponent-yhtextfield/)

public struct YHTextField: View {
    private let title: String
    @Binding private var text: String
    @FocusState private var isFocused: Bool

    public init(
        title: String = "Поиск",
        text: Binding<String>,
    ) {
        self.title = title
        self._text = text
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(isFocused ? Color.purple700 : Color.black50)
                .foregroundStyle(isFocused ? Color.black25 : Color.pureWhite)
                .frame(height: Constants.height)
                .padding(Constants.rectanglePadding)

            HStack(spacing: Constants.hStackSpacing) {
                CommonUIAssets.image(Constants.imageName)
                    .foregroundColor(isFocused ? Color.black900 : Color.black300)

                TextField(title, text: $text)
                    .focused($isFocused)
                    .font(Constants.textFieldFont)
                    .submitLabel(.search)
            }
            .padding(Constants.hStackPadding)
        }
    }
}

private extension YHTextField {
    enum Constants {
        static let cornerRadius: CGFloat = 12
        static let height: CGFloat = 48
        static let rectanglePadding: CGFloat = 16
        static let hStackSpacing: CGFloat = 16
        static let hStackPadding: CGFloat = 32
        static let imageName = "magnifer"
        static let textFieldFont: Font = .manrope(.regular, size: 16)
    }
}

/*
    Документация YHSearchBar
    https://wiki.yandex.ru/homepage/ce33d84eb842/dizajjn-sistemacommonui/komponent-yhsearchbar/
 */

import SwiftUI

public struct YHSearchBar: View {
    
    private let imageName: String
    @Binding var text: String
    private let placeholder: String
    @FocusState private var isFocused: Bool

    public init(
        imageName: String = "magnifer",
        text: Binding<String>,
        placeholder: String = "Профессия, инструмент",
    ) {
        self.imageName = imageName
        self._text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        HStack(spacing: Constants.hStackSpacing) {
            CommonUIAssets.image(imageName)
                .foregroundColor(isFocused ? Color.black900 : Color.black300)

            TextField(placeholder, text: $text)
                .focused($isFocused)
                .font(Constants.textFieldFont)
                .submitLabel(.search)
        }
        .padding(Constants.hStackPadding)
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
}

private extension YHSearchBar {
    enum Constants {
        static let cornerRadius: CGFloat = 12
        static let height: CGFloat = 48
        static let hStackSpacing: CGFloat = 8
        static let hStackPadding: CGFloat = 12
        static let textFieldFont: Font = .manrope(.regular, size: 16)
    }
}

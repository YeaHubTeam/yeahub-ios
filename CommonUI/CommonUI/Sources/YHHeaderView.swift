import SwiftUI

public struct YHHeaderView: View {
    private let title: String
    private let subtitle: String?

    public init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Constants.vStackSpacing) {
            Text(title)
                .font(Constants.titleFont)
                .foregroundStyle(Constants.titleColor)

            if let subtitle {
                Text(subtitle)
                    .font(Constants.subtitleFont)
                    .foregroundStyle(Constants.subtitleColor)
            }
        }
        .padding(.bottom, Constants.vStackBottomPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension YHHeaderView {
    enum Constants {
        static let vStackSpacing: CGFloat = 8
        static let vStackBottomPadding: CGFloat = 8

        static let titleFont: Font = .manrope(.medium, size: 28)
        static let titleColor: Color = .black900

        static let subtitleFont: Font = .manrope(.regular, size: 16)
        static let subtitleColor: Color = .black900
    }
}

#Preview {
    YHHeaderView(title: "Сервис подготовки к собеседованиям", subtitle: "Готовьтесь к собеседованию с подборками вопросов из крупных IT-компаний. Узнайте, какие вопросы задают в Сбере, Т-Банке, Яндексе, Авито, Ozon, VK и других компаниях.")
}

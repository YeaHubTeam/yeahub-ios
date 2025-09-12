import CommonUI
import SwiftUI

struct CollectionsView: View {
    public var onSelectSpecializations: () -> Void

    public init(onSelectSpecializations: @escaping () -> Void) {
        self.onSelectSpecializations = onSelectSpecializations
    }
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.defaultInset) {
            Text(Constants.header)
                .font(Constants.headerFont)
                .foregroundStyle(Color.black900)

            HStack(alignment: .top, spacing: Constants.hStackSpacing) {
                CommonUIAssets.image(Constants.image)

                Text(Constants.collectionDescription)
                    .font(Constants.descriptionFont)
                    .foregroundStyle(Color.black900)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.defaultInset)
            .background(Color.white)
            .cornerRadius(Constants.cornerRadius)

            YHButton(title: Constants.buttonTitle, action: onSelectSpecializations)

            Spacer()
        }
        .padding(.horizontal, Constants.defaultInset)
        .padding(.top, Constants.mainTopPadding)
        .background(Color.black10)
    }
}

private extension CollectionsView {
    enum Constants {
        static let header = "Коллекция"
        static let collectionDescription = "Готовьтесь к собеседованию с подборками вопросов из крупных IT-компаний. Узнайте, какие вопросы задают в Сбере, Т-Банке, Яндексе, Авито, Ozon, VK и других компаниях"
        static let buttonTitle = "Выбрать специальность"

        static let headerFont: Font = .manrope(.semibold, size: 20)
        static let descriptionFont: Font = .manrope(.medium, size: 16)

        static let defaultInset: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let mainTopPadding: CGFloat = 24
        static let horizontalPadding: CGFloat = 12
        static let hStackSpacing: CGFloat = 12

        static let image: String = "Data Science"
    }
}

#Preview {
    CollectionsView(onSelectSpecializations: {})
}

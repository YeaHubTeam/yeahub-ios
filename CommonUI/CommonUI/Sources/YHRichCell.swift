import SwiftUI

struct YHRichCell: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.vStackSpacing) {
            HStack {
                CommonUIAssets.image(Constants.imageName)
                
                Text(Constants.title)
                    .font(.manrope(.medium, size: Constants.titleFontSize))
                    .foregroundColor(.black900)
            }
            
            Text(Constants.description)
                .font(.manrope(.medium, size: Constants.descriptionFontSize))
                .foregroundColor(.black900)
            
            HStack {
                CommonUIAssets.image(Constants.questionMarkIconName)
                
                Text(Constants.tooltip)
                    .font(.manrope(.regular, size: Constants.tooltipFontSize))
                    .foregroundColor(.purple700)
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
private extension YHRichCell {
    enum Constants {
        static let backgroundWidth: CGFloat = 358
        static let cornerRadius: CGFloat = 8
        static let vStackSpacing: CGFloat = 8
        static let inset: CGFloat = 16
        
        static let imageName = "sberIcon"
        
        static let title = "Собеседование на Middle+ Frontend Разработчика в Сбер"
        static let titleFontSize: CGFloat = 16
        
        static let description = "Техническое собеседование для \nэкспертов по основным вопросам React"
        static let descriptionFontSize: CGFloat = 14
        
        static let questionMarkIconName = "questionMarkIcon"
        
        static let tooltip = "30 вопросов"
        static let tooltipFontSize: CGFloat = 12
    }
}

#Preview {
    YHRichCell()
}

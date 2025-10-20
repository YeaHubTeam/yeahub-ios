import SwiftUI

struct YHBubbleCollectionHeader: View {
    let title: String?
    let style: YHBubbleStyle
    
    var body: some View {
        if let title {
            HStack {
                Text(title)
                    .font(Font.sFProText(.medium, size: 16))
                    .foregroundStyle(Color.black600)
            }
            .padding(.horizontal, Constants.titleHorizontalPadding)
            .padding(Constants.titleVerticalPadding)
        }
    }
}

private extension YHBubbleCollectionHeader {
    enum Constants {
        static let titleHorizontalPadding: CGFloat = 16
        static let titleVerticalPadding: CGFloat = 8
    }
}

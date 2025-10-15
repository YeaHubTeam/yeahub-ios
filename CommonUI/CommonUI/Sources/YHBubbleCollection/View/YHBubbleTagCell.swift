import SwiftUI

struct YHBubbleTagCell: View {
    let icon: Image?
    let text: String
    let isSelected: Bool
    let style: YHBubbleStyle
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Constants.verticalPadding) {
                if style.showIcon, let icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.iconSize, height: Constants.iconSize)
                        .foregroundColor(isSelected ? .purple700 : .primary)
                }
                Text(text)
                    .font(Font.sFProText(.medium, size: 16))
                    .lineLimit(Constants.lineLimit)
                    .truncationMode(.tail)
            }
            .padding(.vertical, Constants.verticalPadding)
            .padding(.horizontal, Constants.horizontalPadding)
            .frame(minHeight: Constants.minHeight)
            .background(style.backgroundColor)
            .cornerRadius(Constants.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(isSelected ? Color.purple700 : Color.gray.opacity(0), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

private extension YHBubbleTagCell {
    enum Constants {
        static let iconSize: CGFloat = 20
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 8
        static let minHeight: CGFloat = 42
        static let cornerRadius: CGFloat = 12
        static let borderwidth: CGFloat = 1
        static let lineLimit: Int = 1
    }
}

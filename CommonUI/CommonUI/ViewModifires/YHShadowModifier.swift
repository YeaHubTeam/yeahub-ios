import SwiftUI

struct YHShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(
                color: Color.gray700.opacity(Constants.shadowOpacity),
                radius: Constants.shadowRadius,
                x: Constants.shadowX,
                y: Constants.shadowY
            )
    }
}

public extension View {
    func defaultShadow() -> some View {
        modifier(YHShadowModifier())
    }
}

// MARK: - Constants
private extension YHShadowModifier {
    enum Constants {
        static let shadowX: CGFloat = 0
        static let shadowY: CGFloat = 4
        static let shadowRadius: CGFloat = 10
        static let shadowOpacity = 0.1
    }
}



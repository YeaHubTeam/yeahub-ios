import SwiftUI

public struct YHLoading: View {

    let title: String

    @State private var isAnimating = false

    public init(title: String, isAnimating: Bool = false) {
        self.title = title
        self.isAnimating = isAnimating
    }

    public var body: some View {
        VStack(spacing: Constants.vStackSpacing) {
            HStack(spacing: Constants.hStackSpacing) {
                ForEach(Constants.dots, id: \.self) { index in
                    Circle()
                        .fill(Color.purple700)
                        .frame(width: Constants.dotSize, height: Constants.dotSize)
                        .scaleEffect(isAnimating ? Constants.scaleMaxSize : Constants.scaleMinSize)
                        .animation(
                            Animation.easeInOut(duration: Constants.animationDuration)
                                .repeatForever()
                                .delay(Double(index) * Constants.delay),
                            value: isAnimating
                        )
                }
            }

            Text(title)
                .font(.manrope(.medium, size: Constants.titleFontSize))
                .foregroundColor(.black900)
        }
        .padding(Constants.defaultPadding)
        .frame(width: Constants.roundedRectangleWidth)
        .background(
            RoundedRectangle(cornerRadius: Constants.roundedRectangleCornerRadius)
                .fill(Color.pureWhite)
                .defaultShadow()
        )
        .onAppear {
            isAnimating = true
        }
    }
}

//MARK: - Constants
private extension YHLoading {
    enum Constants {
        static let vStackSpacing: CGFloat = 16
        static let hStackSpacing: CGFloat = 8

        static let dots = Array(0..<3)
        static let dotSize: CGFloat = 12
        static let animationDuration: Double = 0.6
        static let delay: Double = animationDuration / Double(dots.count)
        static let scaleMinSize: CGFloat = 0.5
        static let scaleMaxSize: CGFloat = 1

        static let titleFontSize: CGFloat = 14

        static let defaultPadding: CGFloat = 24
        static let roundedRectangleWidth: CGFloat = 156
        static let roundedRectangleCornerRadius: CGFloat = 12
    }
}

#Preview {
    YHLoading(title: "Loading…")
}

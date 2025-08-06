import SwiftUI

public struct YHLoading: View {

    let title: String

    @State private var isAnimating = false
    private let dotSize: CGFloat = 12
    private let animationDuration: Double = 0.6

    public init(title: String, isAnimating: Bool = false) {
        self.title = title
        self.isAnimating = isAnimating
    }

    public var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(Color.purple700)
                        .frame(width: dotSize, height: dotSize)
                        .scaleEffect(isAnimating ? 1.0 : 0.5)
                        .animation(
                            Animation.easeInOut(duration: animationDuration)
                                .repeatForever()
                                .delay(Double(index) * animationDuration / 3),
                            value: isAnimating
                        )
                }
            }

            // Текст
            Text(title)
                .font(.manrope(.medium, size: 14))
                .foregroundColor(.black900)
        }
        .padding(24)
        .frame(width: 156)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.pureWhite)
                .shadow(
                    color: Color(hex: "#6A6376").opacity(0.1),
                    radius: 10,
                    x: 0,
                    y: 4
                )
        )
        .onAppear {
            isAnimating = true
        }
    }
}

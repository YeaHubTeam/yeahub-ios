import SwiftUI

struct YHLoading: View {

    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: Constants.spacing) {
            Circle()
                .trim(from: Constants.trimFrom, to: Constants.trimTo)
                .stroke(Color.purple700, style: StrokeStyle(lineWidth: Constants.lineWidth, lineCap: .round))
                .rotationEffect(.degrees(isAnimating ? Constants.rotationDegrees : Constants.zeroDegrees))
                .frame(width: Constants.circleSize, height: Constants.circleSize)
                .onAppear {
                    withAnimation(Animation.linear(duration: Constants.duration).repeatForever(autoreverses: false)) {
                        isAnimating = true
                    }
                }

            Text(Constants.title)
                .font(.manrope(.medium, size: Constants.fontSize))
                .foregroundColor(.black900)
        }
        .padding(Constants.inset)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.pureWhite)
                .defaultShadow()
        )
    }
}

// MARK: - Constants
private extension YHLoading {
    enum Constants {
        static let spacing: CGFloat = 16
        static let inset: CGFloat = 24
        static let cornerRadius: CGFloat = 12

        static let title = "Идет загрузка…"
        static let fontSize: CGFloat = 14

        static let trimFrom: CGFloat = 0
        static let trimTo: CGFloat = 0.8
        static let lineWidth: CGFloat = 6

        static let rotationDegrees: CGFloat = 360
        static let zeroDegrees: CGFloat = 0
        static let duration: CGFloat = 1.2

        static let circleSize: CGFloat = 48
    }
}

#Preview {
    YHLoading()
}

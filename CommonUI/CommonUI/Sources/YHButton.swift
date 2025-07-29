import SwiftUI

public struct YHButton: View {

    let title: String
    let action: () -> Void

    private let backgroundColor: Color = .purple700
    private let foregroundColor: Color = .pureWhite
    private let cornerRadius: CGFloat = 12

    @State private var isPressed: Bool = false

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: {
            action()
            withAnimation(.easeInOut(duration: 0.01)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                withAnimation {
                    isPressed = false
                }
            }
        }) {
            Text(title)
                .font(.manrope(.semibold))
                .foregroundColor(foregroundColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
                .scaleEffect(isPressed ? 0.99 : 1.0)
        }
    }
}


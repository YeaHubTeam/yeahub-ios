import SwiftUI

public enum YHButtonState {
    case primaryEnabled
    case primaryDisabled
    case secondaryEnabled
    case secondaryDisabled
    case cancel
}

public struct YHButton: View {

    let title: String
    let state: YHButtonState
    let action: () -> Void

    @State private var isPressed: Bool = false

    public init(
        title: String,
        state: YHButtonState = .primaryEnabled,
        action: @escaping () -> Void
    ) {
        self.state = state
        self.title = title
        self.action = action
    }

    public var body: some View {
        switch state {
        case .primaryEnabled:
            YHStyledButton(
                textColor: .pureWhite,
                backgroundColor: .purple700)
            
        case .primaryDisabled:
            YHStyledButton(
                textColor: .pureWhite,
                backgroundColor: .black100,
                isDisabled: true)
            
        case .secondaryEnabled:
            YHStyledButton(
                textColor: .purple700,
                borderColor: .purple700)
            
        case .secondaryDisabled:
            YHStyledButton(
                textColor: .black100,
                borderColor: .black100,
                isDisabled: true)
            
        case .cancel:
            YHStyledButton(
                textColor: .red600,
                backgroundColor: .red100)
        }
    }
    
    private func YHStyledButton(
        textColor: Color,
        backgroundColor: Color = .clear,
        borderColor: Color = .clear,
        isDisabled: Bool = false
    ) -> some View {
        Button(action: handleButtonAction) {
            Text(title)
                .font(.manrope(.semibold))
                .foregroundColor(textColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(borderColor, lineWidth: borderColor == .clear ? 0 : Constants.lineWidth)
                )
                .cornerRadius(Constants.cornerRadius)
                .scaleEffect(isPressed ? Constants.pressedScale : Constants.normalScale)
        }
        .disabled(isDisabled)
    }
    
    private func handleButtonAction() {
        action()
        
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            isPressed = true
        }
        
        withAnimation(.easeInOut(duration: Constants.animationDuration).delay(Constants.animationDelay)) {
            isPressed = false
        }
    }
}

private extension YHButton {
    enum Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 1
        static let animationDuration: Double = 0.3
        static let animationDelay: Double = 0.1
        static let pressedScale: CGFloat = 0.99
        static let normalScale: CGFloat = 1.0
    }
}

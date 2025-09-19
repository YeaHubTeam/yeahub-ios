import SwiftUI

public enum YHButtonState {
    case primaryEnabled
    case primaryDisabled
    case secondaryEnabled
    case secondaryDisabled
    case cancel
}

public struct YHButton: View {

    let state: YHButtonState
    let title: String
    let action: () -> Void

    @State private var isPressed: Bool = false

    public init(
        state: YHButtonState,
        title: String,
        action: @escaping () -> Void
    ) {
        self.state = state
        self.title = title
        self.action = action
    }

    public var body: some View {
        switch state {
        case .primaryEnabled:
            Button(action: handleButtonAction) {
                Text(title)
                    .font(.manrope(.semibold))
                    .foregroundColor(.pureWhite)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple700)
                    .cornerRadius(Constants.cornerRadius)
                    .scaleEffect(isPressed ? Constants.pressedScale : Constants.normalScale)
            }
            
        case .primaryDisabled:
            Button(action: handleButtonAction) {
                Text(title)
                    .font(.manrope(.semibold))
                    .foregroundColor(.pureWhite)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black100)
                    .cornerRadius(Constants.cornerRadius)
                    .scaleEffect(isPressed ? Constants.pressedScale : Constants.normalScale)
            }
            .disabled(true)
            
        case .secondaryEnabled:
            Button(action: handleButtonAction) {
                Text(title)
                    .font(.manrope(.semibold))
                    .foregroundColor(.purple700)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .stroke(Color.purple700, lineWidth: Constants.lineWidth)
                    )
                    .cornerRadius(Constants.cornerRadius)
                    .scaleEffect(isPressed ? Constants.pressedScale : Constants.normalScale)
            }
            
        case .secondaryDisabled:
            Button(action: handleButtonAction) {
                Text(title)
                    .font(.manrope(.semibold))
                    .foregroundColor(.black100)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .stroke(Color.black100, lineWidth: Constants.lineWidth)
                    )
                    .cornerRadius(Constants.cornerRadius)
                    .scaleEffect(isPressed ? Constants.pressedScale : Constants.normalScale)
            }
            .disabled(true)
            
        case .cancel:
            Button(action: handleButtonAction) {
                Text(title)
                    .font(.manrope(.semibold))
                    .foregroundColor(.red600)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red100)
                    .cornerRadius(Constants.cornerRadius)
                    .scaleEffect(isPressed ? Constants.pressedScale : Constants.normalScale)
            }
        }
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

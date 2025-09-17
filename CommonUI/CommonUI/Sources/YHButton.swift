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

    public init(state: YHButtonState, title: String, action: @escaping () -> Void) {
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
                    .scaleEffect(isPressed ? 0.99 : 1.0)
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
                    .scaleEffect(isPressed ? 0.99 : 1.0)
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
                    .scaleEffect(isPressed ? 0.99 : 1.0)
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
                    .scaleEffect(isPressed ? 0.99 : 1.0)
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
                    .scaleEffect(isPressed ? 0.99 : 1.0)
            }
        }
    }
    
    private func handleButtonAction() {
        action()
        withAnimation(.easeInOut(duration: 0.01)) {
            isPressed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            withAnimation {
                isPressed = false
            }
        }
    }
}

private extension YHButton {
    enum Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 1
    }
}

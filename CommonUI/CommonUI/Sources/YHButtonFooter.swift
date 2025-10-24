import SwiftUI

public struct YHButtonFooter: View {
    
    public struct ButtonConfig {
        let title: String
        let state: YHButton.ButtonState
        let action: () -> Void
        
        public init(title: String,
                    state: YHButton.ButtonState,
                    action: @escaping () -> Void) {
            self.title = title
            self.state = state
            self.action = action
        }
    }
    
    private let leftButton: ButtonConfig?
    private let rightButton: ButtonConfig?
    
    public init(leftButton: ButtonConfig? = nil,
                rightButton: ButtonConfig? = nil) {
        self.leftButton = leftButton
        self.rightButton = rightButton
    }
    
    public var body: some View {
        HStack(spacing: Constants.spacing) {
            if let leftButton {
                YHButton(
                    title: leftButton.title,
                    state: leftButton.state,
                    action: leftButton.action
                )
                    .frame(maxWidth: .infinity)
            } else {
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            
            if let rightButton {
                YHButton(
                    title: rightButton.title,
                    state: rightButton.state,
                    action: rightButton.action
                )
                    .frame(maxWidth: .infinity)
            } else if leftButton != nil {
                Spacer()
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(Color.white)
    }
}

private extension YHButtonFooter {
    enum Constants {
        static let spacing: CGFloat = 12
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 8
    }
}

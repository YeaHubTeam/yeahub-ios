import SwiftUI

public struct YHCustomAlert: View {
    
    public enum AlertType {
        case `default`(
            title: String,
            message: String,
            button: AlertButtonStyle
        )
        case emailConfirmationAlert(
            title: String,
            message: String,
            icon: Image,
            button: AlertButtonStyle
        )
        case custom(
            title: String,
            message: String,
            icon: Image?,
            primaryButton: AlertButtonStyle,
            secondaryButton: AlertButtonStyle?
        )
    }
    
    public struct AlertButtonStyle {
        public let title: String
        public let style: StyleButton
        public let action: () -> Void
        
        public enum StyleButton {
            case primary, secondary
        }
        
        public init(
            title: String,
            style: StyleButton = .primary,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.style = style
            self.action = action
        }
    }
    
    private let alert: AlertType
    private let onClose: () -> Void
    
    public init(alert: AlertType, onClose: @escaping () -> Void) {
        self.alert = alert
        self.onClose = onClose
    }
    
    private var content: (
        title: String,
        message: String,
        icon: Image?,
        buttons: [AlertButtonStyle]
    ) {
        switch alert {
        case let .default(title, message, button):
            (title, message, nil, [button])
        case let .emailConfirmationAlert(title, message, icon, button):
            (title, message, icon, [button])
        case let .custom(title, message, icon, primary, secondary):
            (title, message, icon, [primary, secondary].compactMap { $0 })
        }
    }
    
    private func alertButtonStyle(_ button: AlertButtonStyle) -> some View {
        Button(button.title, action: button.action)
            .font(Constants.buttonTypography)
            .foregroundStyle(Color.purple700)
    }
    
    public var body: some View {
        ZStack {
            Color.black300.opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                Group {
                    content.icon.map { icon in
                        icon
                            .clipped()
                            .scaledToFit()
                            .frame(
                                width: Constants.iconMessageWidth,
                                height: Constants.iconMessageHeight
                            )
                            .padding(.top, Constants.iconMessagePadding)
                    }
                }
                
                Text(content.title)
                    .font(Constants.titleTypography)
                    .multilineTextAlignment(.center)
                    .padding(.top, Constants.titleHorizontalPadding)
                    .padding(.horizontal, Constants.titleHorizontalPadding)
                
                Text(content.message)
                    .foregroundStyle(Color.black700)
                    .font(Constants.messageTypography)
                    .multilineTextAlignment(.center)
                    .padding(.top, Constants.messageVerticalPadding)
                    .padding(.horizontal, Constants.messageHorizontalPadding)
                
                HStack(spacing: Constants.buttonMarginSpacing) {
                    ForEach(content.buttons, id: \.title) { buttonOne in
                        alertButtonStyle(buttonOne)
                    }
                }
                .padding(.top, Constants.buttonTopMargin)
                .padding(.bottom, Constants.buttonBottomMargin)
                
            }
            .padding(.top, Constants.topContentPadding)
            .padding(.horizontal, Constants.containerPadding)
            .background(alertBackground)
            .overlay(closeButton, alignment: .topTrailing)
            .frame(maxWidth: Constants.maxWidth)
        }
    }
    
    private var alertBackground: some View {
        RoundedRectangle(
            cornerRadius: Constants.cornerRadius,
            style: .continuous
        )
        .fill(Color.pureWhite)
        .overlay(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            )
            .stroke(Color.purple700, lineWidth: 1)
        )
    }
    
    private var closeButton: some View {
        Button(action: onClose) {
            Image(.alertCloseIcon)
        }
        .padding([.top, .trailing], Constants.closeButtonPadding)
    }
}

private extension YHCustomAlert {
    enum Constants {
        static let maxWidth: CGFloat = 358
        static let containerPadding: CGFloat = 16
        
        static let cornerRadius: CGFloat = 20
        
        static let iconMessageWidth: CGFloat = 87
        static let iconMessageHeight: CGFloat = 70
        static let iconMessagePadding: CGFloat = 28
        
        static let titleHorizontalPadding: CGFloat = 16
        static let messageHorizontalPadding: CGFloat = 24
        static let messageVerticalPadding: CGFloat = 8
        
        static let buttonVerticalPadding: CGFloat = 16
        static let buttonTopMargin: CGFloat = 36
        static let buttonBottomMargin: CGFloat = 32
        static let buttonMarginSpacing: CGFloat = 16
        
        static let topContentPadding: CGFloat = 44
        static let closeButtonPadding: CGFloat = 12
        
        static let titleTypography: Font = .manrope(.medium, size: 20)
        static let messageTypography: Font = .sFProText(.regular, size: 14)
        static let buttonTypography: Font = .sFProText(.regular, size: 14)
    }
}

private extension YHCustomAlert.AlertButtonStyle {
    static func actionButton(_ title: String, action: @escaping () -> Void) -> Self {
        .init(
            title: title,
            style: .primary,
            action: action
        )
    }
}

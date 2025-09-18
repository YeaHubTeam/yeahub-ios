import SwiftUI

struct YHCustomAlert: View {
    
    var title: String
    var message: String
    var buttonTitle: String
    
    var onButtonTap: () -> Void
    var onClose: () -> Void
    
    var body: some View {
        ZStack {
            Color.black300
                .ignoresSafeArea()
            
            VStack(spacing: Constants.vStackSpace) {
                Image(.alertMessageIcon)
                    .clipped()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: Constants.iconMessageWidth,
                        height: Constants.iconMessageHeight
                    )
                    .padding(.top, Constants.iconMessagePadding)
                
                Text(title)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineLimit(2)
                
                Text(message)
                    .foregroundStyle(Color.black700)
                    .font(Constants.messageTypography)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Constants.massageHorizontalPadding)
                
                Spacer(minLength: 0)
                
                Button(action: onButtonTap) {
                    Text(buttonTitle)
                        .font(Constants.buttonTypography)
                        .foregroundStyle(.purple)
                        .frame(maxWidth: .infinity)
                }
                .padding(.bottom, Constants.buttonPadding)
            }
            .frame(
                width: Constants.bodyWidth,
                height: Constants.bodyWidth
            )
            .background(alertBackground)
            .overlay(closeButton, alignment: .topTrailing)
        }
    }
    
    private var alertBackground: some View {
        RoundedRectangle(
            cornerRadius: Constants.cornetRadius,
            style: .continuous
        )
        .strokeBorder(Color.purple700, lineWidth: 1)
        .background(
            RoundedRectangle(
                cornerRadius: Constants.cornetRadius,
                style: .continuous
            )
            .fill(Color.pureWhite)
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
        static let bodyWidth: CGFloat = 346
        static let bodyHeight: CGFloat = 358
        static let cornetRadius: CGFloat = 20
        static let borderWidth: CGFloat = 1
        static let vStackSpace: CGFloat = 16
        
        static let iconMessageWidth: CGFloat = 87
        static let iconMessageHeight: CGFloat = 70
        static let iconMessagePadding: CGFloat = 28
        
        static let massageHorizontalPadding: CGFloat = 35
        static let buttonPadding: CGFloat = 50
        static let closeButtonPadding: CGFloat = 12
        
        static let titleTypography: Font = .manrope(.regular, size: 20)
        static let messageTypography: Font = .manrope(.regular, size: 14)
        static let buttonTypography: Font = .manrope(.regular, size: 15)
    }
}

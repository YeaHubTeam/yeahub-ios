import SwiftUI

enum YHBaseCellState {
    case speciality(title: String, action: () -> Void = {})
    case question(title: String, action: () -> Void = {})
    case questionDescription(title: String, text: String)
    case answer(title: String, text: String)
}

struct YHBaseCell: View {
    let state: YHBaseCellState
    
    var body: some View {
        switch state {
        
        case .speciality(let title, let action):
            Button(action: action) {
                Text(title)
                    .font(.manrope(.regular, size: Constants.FontSize.subtitle))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: Constants.CellHeight.speciality)
            }
            .baseCellStyle()
            
        case .question(let title, let action):
            Button(action: action) {
                HStack(spacing: Constants.Spacing.bullet) {
                    Circle()
                        .frame(width: Constants.Size.bullet, height: Constants.Size.bullet)
                        .foregroundColor(.purple700)
                    
                    Text(title)
                        .font(.manrope(.regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    
                    Spacer()
                    
                    CommonUIAssets.image(Constants.Icon.arrowIcon)
                        .frame(width: Constants.Size.arrow, height: Constants.Size.arrow)
                }
                .frame(maxWidth: .infinity, minHeight: Constants.CellHeight.question, alignment: .leading)
                .padding(.horizontal, Constants.Padding.horizontal)
            }
            .baseCellStyle()
            
        case .questionDescription(let title, let text):
            VStack(alignment: .leading, spacing: Constants.Spacing.text) {
                Text(title)
                    .font(.manrope(.semibold, size: Constants.FontSize.title))
                    .foregroundColor(.black)
                
                Text(text)
                    .font(.manrope(.regular, size: Constants.FontSize.subtitle))
                    .foregroundColor(.black)
                    .opacity(Constants.Opacity.subtext)
            }
            .padding(.vertical, Constants.Padding.vertical)
            .padding(.horizontal, Constants.Padding.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .baseCellStyle()
            
        case .answer(let title, let text):
            VStack(alignment: .leading, spacing: Constants.Spacing.text) {
                Text(title)
                    .font(.manrope(.semibold, size: Constants.FontSize.title))
                    .foregroundColor(.black)
                
                Text(text)
                    .font(.manrope(.regular, size: Constants.FontSize.subtitle))
                    .foregroundColor(.black)
                    .opacity(Constants.Opacity.subtext)
            }
            .padding(.vertical, Constants.Padding.vertical)
            .padding(.horizontal, Constants.Padding.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .baseCellStyle()
        }
    }
}

struct BaseCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.medium)
                    .fill(Color.pureWhite)
            )
            .padding(.horizontal, Constants.Padding.horizontal)
            .defaultShadow()
    }
}

extension View {
    func baseCellStyle() -> some View {
        modifier(BaseCellModifier())
    }
}

// MARK: - Constants
enum Constants {
    enum CornerRadius {
        static let medium: CGFloat = 12
    }
    
    enum Padding {
        static let horizontal: CGFloat = 12
        static let vertical: CGFloat = 16
    }
    
    enum FontSize {
        static let title: CGFloat = 20
        static let subtitle: CGFloat = 18
    }
    
    enum CellHeight {
        static let speciality: CGFloat = 64
        static let question: CGFloat = 54
    }
    
    enum Size {
        static let bullet: CGFloat = 8
        static let arrow: CGFloat = 20
    }
    
    enum Spacing {
        static let text: CGFloat = 12
        static let bullet: CGFloat = 8
    }
    
    enum Opacity {
        static let subtext: CGFloat = 0.7
    }
    
    enum Icon {
        static let arrowIcon = "rightArrowIcon"
    }
}

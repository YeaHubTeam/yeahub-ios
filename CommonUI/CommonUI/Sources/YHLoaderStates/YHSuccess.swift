import SwiftUI

struct YHSuccess: View {
    var body: some View {
        VStack {
            Text(Constants.stateDescription)
                .font(.manrope(.medium, size: Constants.fontSize))
                .foregroundColor(.black900)
        }
        .padding(Constants.padding)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.pureWhite)
                .defaultShadow()
        )
    }
}

// MARK: - Constsnts
private extension YHSuccess {
    enum Constants {
        static let stateDescription = "Success"
        static let fontSize: CGFloat = 36
        static let padding: CGFloat = 16
        static let cornerRadius: CGFloat = 12
    }
}

#Preview {
    YHSuccess()
}

import SwiftUI

struct YHSuccess: View {
    var body: some View {
        VStack {
            Text("Success")
                .font(.manrope(.medium, size: 36))
                .foregroundColor(.black900)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.pureWhite)
                .defaultShadow()
        )
    }
}

#Preview {
    YHSuccess()
}

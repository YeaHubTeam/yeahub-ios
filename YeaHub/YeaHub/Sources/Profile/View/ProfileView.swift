import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.black25
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("В РАЗРАБОТКЕ! \n СПАСИБО ЗА ОЖИДАНИЕ 💜")
                    .font(Font.sFProDisplay(.medium, size: 25))
                    .foregroundColor(Color.purple700)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

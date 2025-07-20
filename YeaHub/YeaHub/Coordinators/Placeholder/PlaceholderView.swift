import SwiftUI

struct PlaceholderView: View {
    let title: String
    let backgroundColor: Color

    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("\(title) Tab")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("This is a placeholder.")
                        .font(.title2)

                    Text("Will be replaced with actual \(title)Module.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.white)
                .padding()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

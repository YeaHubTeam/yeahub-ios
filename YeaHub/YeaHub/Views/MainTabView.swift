import SwiftUI

struct MainTabView: View {
    @StateObject private var mainCoordinator = MainCoordinatorImpl()

    var body: some View {
        TabView(selection: $mainCoordinator.selectedTab) {
            // TODO: Replace with actual module views
            // when HomeModule, QuestionsModule, QuestionsCollectionsModule are created

            // Home Tab
            PlaceholderView(title: "Home", backgroundColor: .blue)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)

            // Questions Tab
            PlaceholderView(title: "Questions", backgroundColor: .green)
                .tabItem {
                    Image(systemName: "questionmark.circle")
                    Text("Questions")
                }
                .tag(1)

            // Collections Tab
            PlaceholderView(title: "Collections", backgroundColor: .orange)
                .tabItem {
                    Image(systemName: "folder")
                    Text("Collections")
                }
                .tag(2)
        }
        .onAppear {
            mainCoordinator.start()
        }
    }
}

#Preview {
    MainTabView()
}

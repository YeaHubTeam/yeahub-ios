import UIKit
import SwiftUI

public class SpecialtyFactoryImpl: SpecialtyFactory {
    public init() {}

    public func makeSpecialtyListScreen() -> UIViewController {
        let swiftUIView = SpecialtyListView()
        let hosting = UIHostingController(rootView: swiftUIView)
        hosting.view.backgroundColor = .systemBackground
        return hosting
    }
    
    public func makeSpecialtyDetailScreen(for specialty: String) -> UIViewController {
        SpecialtyDetailViewController(specialty: specialty)
    }
}

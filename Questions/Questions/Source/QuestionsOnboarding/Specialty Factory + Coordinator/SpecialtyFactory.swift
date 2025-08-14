import UIKit

public protocol SpecialtyFactory {
    func makeSpecialtyListScreen() -> UIViewController
    func makeSpecialtyDetailScreen(for specialty: String) -> UIViewController
}

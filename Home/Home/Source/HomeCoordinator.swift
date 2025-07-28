import NavigationKit
import UIKit

public protocol HomeCoordinator: Coordinator {

    var factory: HomeFactory { get }

    func start()
    func getHomeScreen() -> HomeViewController?
}

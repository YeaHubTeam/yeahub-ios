import NavigationKit
import UIKit

public protocol ProfileCoordinator: Coordinator {

    var factory: ProfileFactory { get }

    func start()
    func getProfileScreen() -> ProfileViewController?
}

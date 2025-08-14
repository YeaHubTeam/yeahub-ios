import NavigationKit
import UIKit

public class SpecialtyCoordinatorImpl: SpecialtyCoordinator {
    public var router: Router
    public var factory: SpecialtyFactory

    public init(router: Router, factory: SpecialtyFactory) {
        self.router = router
        self.factory = factory
    }

    public func start() {
        let listVC = factory.makeSpecialtyListScreen()
        router.push(listVC)
    }
}

import NeedleFoundation
import NavigationKit

protocol AppFactory: Dependency {

    func makeMainCoordinator(router: Router) -> MainCoordinator
}

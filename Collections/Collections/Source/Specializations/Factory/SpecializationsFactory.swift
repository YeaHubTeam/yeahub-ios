import NavigationKit

public protocol SpecializationsFactory {
//    func makeSpecializationsCoordinator(router: Router) -> SpecializationsCoordinator
    func makeSpecializationsScreen() -> SpecializationsViewController
}

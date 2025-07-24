import NeedleFoundation

protocol AppFactory: Dependency {
    func makeMainCoordinator() -> MainCoordinator
}

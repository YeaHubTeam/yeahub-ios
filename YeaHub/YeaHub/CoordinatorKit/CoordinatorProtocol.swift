protocol CoordinatorProtocol: AnyObject {
    func start()
    func finish()
}

protocol ChildCoordinatorManaging: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    func addChild(_ coordinator: CoordinatorProtocol)
    func removeChild(_ coordinator: CoordinatorProtocol)
}

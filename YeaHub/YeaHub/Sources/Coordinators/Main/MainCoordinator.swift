import NavigationKit

protocol MainCoordinator: Coordinator {

    var factory: MainFactory { get set }

    func start()
}

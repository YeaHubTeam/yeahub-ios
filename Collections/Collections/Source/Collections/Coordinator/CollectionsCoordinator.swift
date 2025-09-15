import NavigationKit

public protocol CollectionsCoordinator: Coordinator {
    var factory: CollectionsFactory { get }

    func start()
    func getCollectionScreen() -> CollectionsViewController?
}

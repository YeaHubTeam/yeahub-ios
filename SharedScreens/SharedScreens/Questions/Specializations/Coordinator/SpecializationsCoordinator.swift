import NavigationKit

public protocol SpecializationsCoordinator: Coordinator {
    var factory: SpecializationsFactory { get }

    func start()
    func startQuestionFlow(id: Int)
}

import NavigationKit

public protocol SpecializationsCoordinator: Coordinator {
    var factory: SpecializationsFactory { get }

    func start()
    func getSpecializationsScreen() -> SpecializationsViewController?
    func startQuestionFlow(text: Int)
}

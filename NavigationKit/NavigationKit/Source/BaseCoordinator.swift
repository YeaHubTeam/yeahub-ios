import Foundation

/// Base class for all coordinators in the App. Implements Coordinator protocol
/// Be free to use it for new coordinator
open class BaseCoordinator: Deinitable {

    // MARK: - Deinitable

    public lazy var onDeinit: () -> Void = { [weak self] in
        self?.removeFromParent()
    }

    // MARK: - Private Properties

    private var childCoordinators: [Coordinator] = []
    private weak var parentCoordinator: BaseCoordinator?

    // MARK: - Initialization

    public init() {}

    // MARK: - Public Methods

    public func addDependency(_ coordinator: Coordinator) {
        guard !hasDependency(coordinator) else {
            return
        }
        childCoordinators.append(coordinator)

        if let child = coordinator as? BaseCoordinator {
            child.parentCoordinator = self
        }
    }

    public func removeDependency(_ coordinator: Coordinator?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator
        else {
            return
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    public func removeAllDependencies() {
        childCoordinators.removeAll()
    }

    public func removeFromParent() {
        guard let coordinator = self as? Coordinator else { return }
        parentCoordinator?.removeDependency(coordinator)
    }

    public func start(_ coordinator: Coordinator & Deinitable) {
        addDependency(coordinator)
        coordinator.start()
    }

    /// Recursively looks for a coordinator in the hierarchy that conforms to the type T
    /// - Parameters:
    ///     - of: T – target coordinator type
    public func parent<T>(of type: T.Type) -> T? {
        (parentCoordinator as? T) ?? parentCoordinator.flatMap { $0.parent(of: type) }
    }
}

// MARK: - Private Methods

private extension BaseCoordinator {

    func hasDependency(_ coordinator: Coordinator) -> Bool {
        childCoordinators.contains { $0 === coordinator }
    }
}

public protocol DebugRoutesSource {

    var debugRoutes: [String: () -> Void] { get }
}

public protocol TypedDebugRoutesSource: DebugRoutesSource where DebugStep.RawValue == String {

    associatedtype DebugStep: Hashable & RawRepresentable
    var typedDebugRoutes: [DebugStep: () -> Void] { get }
}

public extension DebugRoutesSource where Self: TypedDebugRoutesSource {

    var debugRoutes: [String: () -> Void] {
        Dictionary(typedDebugRoutes.map { ($0.rawValue, $1) }) { _, new in
            new
        }
    }
}

public extension BaseCoordinator {

    var allDebugRoutes: [String: () -> Void] {
        childCoordinators
            .compactMap { ($0 as? BaseCoordinator)?.allDebugRoutes }
            .reduce([:]) { partialResult, routes in
                partialResult.merging(routes) { _, new in new }
            }
            .merging((self as? DebugRoutesSource)?.debugRoutes ?? [:]) { _, new in new }
    }
}

// MARK: - Resolving Coordinators

public extension BaseCoordinator {

    func resolveFirstChildCoordinator<T>(type: T.Type) -> T? {
        let baseCoordinators = childCoordinators.compactMap { $0 as? BaseCoordinator }
        for coordinator in baseCoordinators {
            if let coordinator = coordinator as? T {
                return coordinator
            }
            if let coordinator = coordinator.resolveFirstChildCoordinator(type: type) {
                return coordinator
            }
        }
        return nil
    }
}

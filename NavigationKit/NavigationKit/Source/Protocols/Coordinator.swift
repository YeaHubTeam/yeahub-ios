import NeedleFoundation

public protocol Coordinator: AnyObject, Dependency {
    
    func start()
}

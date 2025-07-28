public protocol Deinitable {

    var onDeinit: () -> Void { get set }
}

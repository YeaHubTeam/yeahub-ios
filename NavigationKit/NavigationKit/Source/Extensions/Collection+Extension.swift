import Foundation

public extension Collection {

    /// Return the element at the specified index only if it is within bounds, otherwise nil.
    ///
    /// - Parameter index: The position of the element to get.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Collection {

    var isNotEmpty: Bool {
        !isEmpty
    }

    @_disfavoredOverload
    func count(where condition: (Element) -> Bool) -> Int {
        reduce(into: 0) {
            if condition($1) {
                $0 += 1
            }
        }
    }
}

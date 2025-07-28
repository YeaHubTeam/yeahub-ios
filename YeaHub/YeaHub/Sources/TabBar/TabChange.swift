public struct TabChange: Hashable {

    public let previousIndex: Int?
    public let currentIndex: Int

    public init(
        previousIndex: Int?,
        currentIndex: Int
    ) {
        self.previousIndex = previousIndex
        self.currentIndex = currentIndex
    }
}

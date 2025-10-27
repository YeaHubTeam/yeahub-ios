import Foundation

public struct TagItem: Identifiable, Hashable {
    public let id: Int
    public let title: String
    public let icon: YHBubbleTagIcon?
    
    public init(
        id: Int,
        title: String,
        icon: YHBubbleTagIcon? = nil
    ) {
        self.id = id
        self.title = title
        self.icon = icon
    }
}

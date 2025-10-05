import Foundation

public struct TagItem: Identifiable, Hashable {
    public let id = UUID()
    public let title: String
    public let icon: YHBubbleTagIcon?
    
    public init(
        title: String,
        icon: YHBubbleTagIcon? = nil
    ) {
        self.title = title
        self.icon = icon
    }
}

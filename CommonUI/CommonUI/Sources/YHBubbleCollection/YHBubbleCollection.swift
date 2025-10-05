import SwiftUI

public struct YHBubbleCollection: View {
    
    public let collection: YHBubbleTagConfiguration
    @Binding public var selected: Set<UUID>
    
    public init(
        collection: YHBubbleTagConfiguration,
        selected: Binding<Set<UUID>> = .constant([])
    ) {
        self.collection = collection
        self._selected = selected
    }
    
    var content: (
        title: String?,
        textColor: Color,
        categories: [TagItem],
        style: YHBubbleStyle
    ) {
        switch collection {
        case let .textOnly(categories):
            let style: YHBubbleStyle = .textOnly
            return (nil, style.textColor, categories, style)
        case let .withIconTitle(title, categories, showIcons):
            let style: YHBubbleStyle = showIcons ? .withIconTitle : .textOnly
            return (title, style.textColor, categories, style)
        }
    }
    
    public var body: some View {
        let data = content
        
        VStack(alignment: .leading, spacing: 1) {
            YHBubbleCollectionHeader(
                title: data.title,
                style: data.style
            )
            YHBubbleCollectionBody(
                categories: data.categories,
                style: data.style,
                selected: $selected
            )
            .foregroundStyle(data.textColor)
        }
        .background(data.style.containerBackgroundColor)
    }
}

import SwiftUI

public enum YHBubbleSelectionMode {
    case single
    case multiple
}

public struct YHBubbleCollection: View {
    
    public let collection: YHBubbleTagConfiguration
    @Binding public var selected: Set<Int>
    public let selectionMode: YHBubbleSelectionMode
    
    public init(
        collection: YHBubbleTagConfiguration,
        selected: Binding<Set<Int>> = .constant([]),
        selectionMode: YHBubbleSelectionMode = .multiple
    ) {
        self.collection = collection
        self._selected = selected
        self.selectionMode = selectionMode
    }
    
    private var content: (
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
                selected: $selected,
                selectionMode: selectionMode
            )
            .foregroundStyle(data.textColor)
        }
        .background(data.style.containerBackgroundColor)
    }
}

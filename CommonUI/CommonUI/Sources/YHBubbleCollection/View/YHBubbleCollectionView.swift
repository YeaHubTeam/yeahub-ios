import SwiftUI

struct YHBubbleCollectionBody: View {
    let categories: [TagItem]
    let style: YHBubbleStyle
    @Binding var selected: Set<UUID>
    
    var body: some View {
        VStack {
            YHBubbleCollectionLayout(spacing: Constants.bubbleSpacing) {
                ForEach(categories) { tag in
                    YHBubbleTagCell(
                        icon: tag.icon?.image,
                        text: tag.title,
                        isSelected: selected.contains(tag.id),
                        style: style
                    ) {
                        toggle(tag)
                    }
                }
            }
            .padding(.horizontal, Constants.contentHorizontalPadding)
            .background(Color.black25)
        }
    }
    
    private func toggle(_ tag: TagItem) {
        withAnimation(.easeInOut(duration: 0.1)) {
            if selected.contains(tag.id) {
                selected.remove(tag.id)
            } else {
                selected.insert(tag.id)
            }
        }
    }
}

private extension YHBubbleCollectionBody {
    enum Constants {
        static let bubbleSpacing: CGFloat = 12
        static let contentHorizontalPadding: CGFloat = 16
    }
}

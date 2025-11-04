import SwiftUI

struct YHBubbleCollectionBody: View {
    let categories: [TagItem]
    let style: YHBubbleStyle
    @Binding var selected: Set<Int>
    let selectionMode: YHBubbleSelectionMode
    
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
            switch selectionMode {
            case .single:
                if selected.contains(tag.id) {
                    selected.remove(tag.id)
                } else {
                    selected = [tag.id]
                }
            case .multiple:
                if selected.contains(tag.id) {
                    selected.remove(tag.id)
                } else {
                    selected.insert(tag.id)
                }
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

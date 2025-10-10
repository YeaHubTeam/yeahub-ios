import SwiftUI

struct YHBubbleCollectionLayout: Layout {
    var spacing: CGFloat = 12
    var maxItemWidth: CGFloat? = nil
    
    func makeCache(subviews: Subviews) -> [CGSize] {
        Array(repeating: .zero, count: subviews.count)
    }
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout [CGSize]
    ) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        var lineHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity
        let itemMaxWidth = maxItemWidth ?? maxWidth
        
        for (index, subview) in subviews.enumerated() {
            if cache[index] == .zero {
                cache[index] = subview.sizeThatFits(
                    ProposedViewSize(
                        width: itemMaxWidth,
                        height: nil
                    )
                )
            }
            let size = cache[index]
            
            if width + size.width > maxWidth, width > 0 {
                width = 0
                height += lineHeight + spacing
                lineHeight = 0
            }
            
            width += size.width + (width > 0 ? spacing : 0)
            lineHeight = max(lineHeight, size.height)
        }
        
        height += lineHeight
        return CGSize(
            width: maxWidth,
            height: height
        )
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout [CGSize]
    ) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var lineHeight: CGFloat = 0
        
        for (index, subview) in subviews.enumerated() {
            let size = cache[index]
            
            if x + size.width > bounds.maxX, x > bounds.minX {
                x = bounds.minX
                y += lineHeight + spacing
                lineHeight = 0
            }
            
            subview.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(
                    width: size.width,
                    height: size.height
                )
            )
            
            x += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
    }
}

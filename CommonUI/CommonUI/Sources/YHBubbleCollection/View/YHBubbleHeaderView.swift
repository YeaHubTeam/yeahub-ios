import SwiftUI

struct YHBubbleCollectionHeader: View {
    let title: String?
    let style: YHBubbleStyle
    
    var body: some View {
        if let title = title {
            HStack {
                Text(title)
                    .font(Font.sFProText(.medium, size: 16))
                    .foregroundStyle(Color.black600)
            }
            .padding(.horizontal, 16)
            .padding(8)
        }
    }
}

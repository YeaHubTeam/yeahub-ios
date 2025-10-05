import SwiftUI

public enum YHBubbleTagConfiguration {
    case textOnly(categories: [TagItem])
    case withIconTitle(
        title: String,
        categories: [TagItem],
        showIcons: Bool
    )
}

enum YHBubbleStyle {
    case textOnly
    case withIconTitle
    
    var textColor: Color {
        switch self {
        case .textOnly:
//                .blue
                .black700
        case .withIconTitle:
//                .red
                .black600
        }
    }
    
    var showIcon: Bool {
        switch self {
        case .textOnly:
            false
        case .withIconTitle:
            true
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .textOnly:
                .pureWhite
        case .withIconTitle:
                .black50
        }
    }
    
    var containerBackgroundColor: Color {
        .black25
    }
}

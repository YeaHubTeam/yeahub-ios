import SwiftUI

public enum YHBubbleTagIcon {
    case wireframing
    case figma
    
    var image: Image {
        switch self {
        case .wireframing:
            Image(.wireframing)
        case .figma:
            Image(.figma)
        }
    }
}

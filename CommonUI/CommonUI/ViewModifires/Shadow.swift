//
// Copyright © 2025. All rights reserved.
//

import SwiftUI

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.gray700.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}

public extension View {
    func shadow() -> some View {
        modifier(Shadow())
    }
}

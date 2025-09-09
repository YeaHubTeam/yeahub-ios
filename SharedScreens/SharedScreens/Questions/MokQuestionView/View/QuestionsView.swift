import CommonUI
import SwiftUI

struct QuestionsView: View {
    var text: Int

    var body: some View {
        Text(String(text))
    }
}

#Preview {
    QuestionsView(text: 123456)
}

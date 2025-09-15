import CommonUI
import SwiftUI

struct QuestionsView: View {
    var id: Int

    var body: some View {
        Text(String(id))
    }
}

#Preview {
    QuestionsView(id: 123456)
}

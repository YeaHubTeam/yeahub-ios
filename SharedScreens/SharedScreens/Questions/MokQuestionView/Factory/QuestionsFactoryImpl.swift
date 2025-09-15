import NavigationKit
import Networking

public final class QuestionsFactoryImpl: QuestionsFactory {
    let id: Int
    public init(id: Int) {
        self.id = id
    }

    public func makeQuestionsScreen() -> QuestionsViewController {
        QuestionsViewController(id: id)
    }
}

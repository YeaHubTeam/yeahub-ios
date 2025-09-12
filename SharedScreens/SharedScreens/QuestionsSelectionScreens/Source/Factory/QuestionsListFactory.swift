import Foundation
import NavigationKit

public protocol QuestionsListFactory {
    func makeQuestionsListScreen() -> QuestionsListViewController
}

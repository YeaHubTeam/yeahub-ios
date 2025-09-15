import Foundation
import NavigationKit

public protocol QuestionsListFactory {
    func makeQuestionsListScreen(specializationId: Int, specializationTitle: String) -> QuestionsListViewController
}

import Foundation
import NavigationKit

public protocol QuestionFactory {
    func makeQuestionScreen() -> QuestionViewController
}

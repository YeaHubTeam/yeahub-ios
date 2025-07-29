import NavigationKit
import UIKit

public protocol QuestionsOnboardingCoordinator: Coordinator {

    var factory: QuestionsOnboardingFactory { get }

    func start()
    func getQuestionsOnboardingScreen() -> QuestionsOnboardingViewController?
}

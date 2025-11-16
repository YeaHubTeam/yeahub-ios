import SwiftUI
import NavigationKit
import CommonUI
import SharedScreens

class MainCoordinatorImpl: BaseCoordinator, MainCoordinator {
    
    var factory: MainFactory
    
    private weak var tabBarController: UITabBarController?
    private let router: Router
    
    private var childCoordinators: [Coordinator] = []
    
    init(
        router: Router,
        factory: MainFactory
    ) {
        self.router = router
        self.factory = factory
        super.init()
    }
    
    func start() {
        showTabBar()
    }
    
    private func showTabBar() {
        let tabBarController = YHTabBarController()
        self.tabBarController = tabBarController
        
        configureTabs(for: tabBarController)
        
        router.setRoot(tabBarController, animated: true)
    }
    
    private func configureTabs(for tabBarController: UITabBarController) {
        // Создаем координаторы
        let homeCoordinator = factory.makeHomeCoordinator(router: router)
        let questionsCoordinator = factory.makeQuestionsOnboardingCoordinator(router: router)
        let collectionsCoordinator = factory.makeCollectionsCoordinator(router: router)
        
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(questionsCoordinator)
        childCoordinators.append(collectionsCoordinator)
        
        homeCoordinator.start()
        questionsCoordinator.start()
        collectionsCoordinator.start()
        
        guard let homeVC = homeCoordinator.getHomeScreen()?.toPresent(),
              let questionsVC = questionsCoordinator.getQuestionsOnboardingScreen()?.toPresent(),
              let collectionsVC = collectionsCoordinator.getCollectionScreen()?.toPresent()
        else {
            return
        }
        
        let homeNav = NavControllerWithHiddenStatusBar(rootViewController: homeVC)
        let questionsNav = NavControllerWithHiddenStatusBar(rootViewController: questionsVC)
        let collectionsNav = NavControllerWithHiddenStatusBar(rootViewController: collectionsVC)
        
        homeNav.tabBarItem = UITabBarItem(
            title: "Главная",
            image: CommonUIAssets.homeVCImageTabBarLogo,
            tag: 1
        )
        
        questionsNav.tabBarItem = UITabBarItem(
            title: "Вопросы",
            image: CommonUIAssets.questionsVCImageTabBarLogo,
            tag: 2
        )
        
        collectionsNav.tabBarItem = UITabBarItem(
            title: "Коллекции",
            image: CommonUIAssets.collectionsVCImageTabBarLogo,
            tag: 3
        )
        
        var viewControllers: [UIViewController] = []

        viewControllers.append(contentsOf: [homeNav, questionsNav, collectionsNav])
        
        if #available(iOS 26, *) {
            let profileCoordinator = factory.makeProfileCoordinator(router: router)
            childCoordinators.append(profileCoordinator)
            profileCoordinator.start()
            
            if let profileVC = profileCoordinator.getProfileScreen()?.toPresent() {
                let profileNav = NavControllerWithHiddenStatusBar(rootViewController: profileVC)
                profileNav.tabBarItem = UITabBarItem(
                    title: "Профиль",
                    image: CommonUIAssets.profileVCImageTabBarLogo,
                    tag: 0
                )
                viewControllers.append(profileNav)
            }
        }
        
        tabBarController.viewControllers = viewControllers
    }
}

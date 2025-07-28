import UIKit
import NavigationKit
import Home

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinatorImpl?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupWindowForSwiftUIProject()
        return true
    }

    private func setupWindowForSwiftUIProject() {
        // Создаем первоначальное окно
        window = UIWindow(frame: UIScreen.main.bounds)

        // Создаем временный view controller чтобы окно стало key
        let tempVC = UIViewController()
        tempVC.view.backgroundColor = .systemRed
        window?.rootViewController = tempVC
        window?.makeKeyAndVisible()

        // "Nuclear reset" для SwiftUI проектов - создаем новое рабочее окно
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.createWorkingWindow()
        }
    }

    private func createWorkingWindow() {
        // Создаем новое рабочее окно
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        newWindow.makeKeyAndVisible()
        window = newWindow

        // Запускаем координаторы после создания рабочего окна
        setupCoordinatorSystem()
    }

    private func setupCoordinatorSystem() {
        guard window != nil else { return }

        let router = MainRouter()
        let appFactory = AppFactoryImpl()
        appCoordinator = AppCoordinatorImpl(router: router, appFactory: appFactory)
        appCoordinator?.start()
    }
}

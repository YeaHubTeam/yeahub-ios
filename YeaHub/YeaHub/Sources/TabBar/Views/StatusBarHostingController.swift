import SwiftUI
import UIKit

final class StatusBarHostingController<Content: View>: UIHostingController<Content> {

    private let hideStatusBar: Bool

    // MARK: Life Cycle

    init(rootView: Content, hideStatusBar: Bool = false) {
        self.hideStatusBar = hideStatusBar
        super.init(rootView: rootView)
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Принудительно обновляем статус бар при появлении view
        setNeedsStatusBarAppearanceUpdate()
    }

    override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

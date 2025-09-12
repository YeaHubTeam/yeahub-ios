import SwiftUI
import UIKit

public final class StatusBarHostingController<Content: View>: UIHostingController<Content> {

    private let hideStatusBar: Bool

    // MARK: Life Cycle

    public init(rootView: Content, hideStatusBar: Bool = false) {
        self.hideStatusBar = hideStatusBar
        super.init(rootView: rootView)
    }

    @MainActor required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    public override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }

    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

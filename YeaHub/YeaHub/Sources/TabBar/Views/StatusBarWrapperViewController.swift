import UIKit
import SwiftUI

final class StatusBarWrapperViewController: UIViewController {

    private let wrappedViewController: UIViewController
    private let hideStatusBar: Bool

    // MARK: Life Cycle
    
    init(wrappedViewController: UIViewController, hideStatusBar: Bool) {
        self.wrappedViewController = wrappedViewController
        self.hideStatusBar = hideStatusBar
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(wrappedViewController)
        view.addSubview(wrappedViewController.view)
        wrappedViewController.view.frame = view.bounds
        wrappedViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wrappedViewController.didMove(toParent: self)
    }

    override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

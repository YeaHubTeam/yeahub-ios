import UIKit

public final class StatusBarWrapperViewController: UIViewController {

    private let wrappedViewController: UIViewController
    private let hideStatusBar: Bool

    // MARK: Life Cycle
    
   public init(wrappedViewController: UIViewController, hideStatusBar: Bool) {
        self.wrappedViewController = wrappedViewController
        self.hideStatusBar = hideStatusBar
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addChild(wrappedViewController)
        view.addSubview(wrappedViewController.view)
        wrappedViewController.view.frame = view.bounds
        wrappedViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wrappedViewController.didMove(toParent: self)
    }

    private func setupNavigationBar() {
        navigationItem.backButtonDisplayMode = .minimal
    }

    public override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }

    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

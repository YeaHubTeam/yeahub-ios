import UIKit
import SwiftUI

public class HomeViewController: UIViewController {
    private let onQuestionsSelected: () -> Void
    private let onCollectionsSelected: () -> Void

    override public var prefersStatusBarHidden: Bool {
        true
    }
    
    public init(
        onQuestionsSelected: @escaping () -> Void,
        onCollectionsSelected: @escaping () -> Void
    ) {
        self.onQuestionsSelected = onQuestionsSelected
        self.onCollectionsSelected = onCollectionsSelected
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.onQuestionsSelected = {}
        self.onCollectionsSelected = {}
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUIView()
        navigationItem.backButtonDisplayMode = .minimal
    }

    public override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupSwiftUIView() {
        let homeView = HomeView(
            onQuestionsSelected: onQuestionsSelected,
            onCollectionsSelected: onCollectionsSelected
        )
        let hostingController = UIHostingController(rootView: homeView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        hostingController.view.backgroundColor = .clear
    }
}

import SwiftUI
import UIKit

public final class CollectionsViewController: UIViewController {
    public let viewModel: CollectionsViewModel
    private let onSelectSpecializations: () -> Void

    public init(viewModel: CollectionsViewModel, onSelectSpecializations: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onSelectSpecializations = onSelectSpecializations
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUIView()
    }

    private func setupSwiftUIView() {
        let collectionsView = CollectionsView(onSelectSpecializations: onSelectSpecializations)
        let hostingController = UIHostingController(rootView: collectionsView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        hostingController.view.backgroundColor = .clear
    }
}

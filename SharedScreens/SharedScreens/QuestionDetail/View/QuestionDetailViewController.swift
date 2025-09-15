import UIKit
import SwiftUI

public final class QuestionDetailViewController: UIViewController {
    public let viewModel: QuestionDetailViewModel
    
    public init(viewModel: QuestionDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let initialView = UIView()
        initialView.backgroundColor = UIColor.gray
        view = initialView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSUIView()
    }

    func setupSUIView() {
        let questionDetailView = QuestionDetailView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: questionDetailView)

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

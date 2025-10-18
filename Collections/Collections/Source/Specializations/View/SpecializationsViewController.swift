import CommonUI
import SwiftUI
import UIKit

public class SpecializationsViewController: UIViewController {
    public let viewModel: SpecializationsViewModel

    public init(viewModel: SpecializationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        let initialView = UIView()
        initialView.backgroundColor = UIColor(Color.black10)
        view = initialView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSwiftUIView()
    }

    private func setupNavigationBar() {
        title = Constants.title

        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Constants.titleColor,
            .font: Constants.titleFont
        ]
        
        navigationController?.navigationBar.tintColor = Constants.backButtonTintColor
    }

    private func setupSwiftUIView() {
        let specializationsView = SpecializationsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: specializationsView)

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

private extension SpecializationsViewController {
    enum Constants {
        static let title = "Выбор специальности"
        static let titleColor = UIColor(.black900)
        static let titleFont = UIFont.manrope(.medium, size: 16)

        static let backButtonTintColor = UIColor(.purple700)
    }
}

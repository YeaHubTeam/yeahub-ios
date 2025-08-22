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
        let v = UIView()
        v.backgroundColor = UIColor(Color.black10)
        view = v
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSwiftUIView()
    }

    private func setupNavigationBar() {
        title = "Выбор специальности"

        let appearance = UINavigationBarAppearance()

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(.black900),
            .font: UIFont.manrope(.medium, size: 16)
        ]

        navigationController?.navigationBar.tintColor = UIColor(.purple700)

    }

    private func setupSwiftUIView() {
        let specializationsView = SpecializationsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: specializationsView)

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

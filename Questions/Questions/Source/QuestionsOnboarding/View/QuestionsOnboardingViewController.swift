import UIKit
import SwiftUI

public class QuestionsOnboardingViewController: UIViewController {

    private let onSelectSpecialty: () -> Void

    public init(onSelectSpecialty: @escaping () -> Void) {
        self.onSelectSpecialty = onSelectSpecialty
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.onSelectSpecialty = {}
        super.init(coder: coder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUIView()
    }

    private func setupSwiftUIView() {
        let questionsOnboardingView = QuestionsOnboardingView(onSelectSpecialty: onSelectSpecialty)
        let hostingController = UIHostingController(rootView: questionsOnboardingView)

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

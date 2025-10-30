import CommonUI
import SwiftUI
import UIKit

public class QuestionsListViewController: UIViewController {
    public let viewModel: QuestionsViewModel
    private let specializationTitle: String
    
    public init(viewModel: QuestionsViewModel, specializationTitle: String) {
        self.viewModel = viewModel
        self.specializationTitle = specializationTitle
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
        title = specializationTitle
        
        navigationController?.navigationBar.tintColor = Constants.chevronColor
        navigationItem.backButtonDisplayMode = .minimal
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: (Constants.questionColor),
            .font: Constants.questionFont
        ]
    }
    
    private func setupSwiftUIView() {
        let questionsListView = QuestionsListView(viewModel: viewModel, specializationTitle: viewModel.selectedSpecializations)
        let hostingController = UIHostingController(rootView: questionsListView)
        
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
        
        hostingController.view.backgroundColor = UIColor.clear
    }
}


private extension QuestionsListViewController {
    
    enum Constants {
        static let chevronColor = UIColor(Color.purple700)
        
        static let questionFont = UIFont.manrope(.medium, size: 16)
        static let questionColor = UIColor(Color.black900)
    }
}

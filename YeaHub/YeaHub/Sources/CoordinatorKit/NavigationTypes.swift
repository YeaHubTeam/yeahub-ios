enum NavigationRequest {
    case home
    case questions
    case questionsCollections
    case custom(String, [String: Any])
}

protocol NavigationDelegate: AnyObject {
    func handle(navigationRequest: NavigationRequest)
}

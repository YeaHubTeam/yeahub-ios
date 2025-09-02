import SwiftUI

public struct YHLoader<Content: View>: View {
    let state: LoadingState
    let successView: () -> Content

    public init(state: LoadingState, @ViewBuilder successView: @escaping () -> Content) {
        self.state = state
        self.successView = successView
    }

    public var body: some View {
        switch state {
        case .success:
            successView()

        case .loading(let title):
            YHLoading(title: title)

        case .commonError(let errorDescription):
            YHCommonError(title: errorDescription)

        case .error404(let title):
            YHError404(title: title)
        }
    }
}

// MARK: - States
public enum LoadingState: Equatable {
    case success
    case loading(title: String)
    case commonError(title: String)
    case error404(title: String)
}

#Preview {
    YHLoader(state: .success) {
        YHSuccess()
    }
}

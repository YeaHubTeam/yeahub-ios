import SwiftUI

public struct YHLoader<Content: View>: View {
    let state: LoadingState
    let refresh: (() -> Void)?
    let successView: () -> Content

    public init(state: LoadingState, refresh: (() -> Void)?, @ViewBuilder successView: @escaping () -> Content) {
        self.state = state
        self.refresh = refresh
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

        case .requestTimedOut:
            YHConnectionLost(refresh: refresh ?? {})
        }
    }
}

// MARK: - States
public enum LoadingState: Equatable {
    case success
    case loading(title: String)
    case commonError(title: String)
    case error404(title: String)
    case requestTimedOut
}

#Preview {
    YHLoader(state: .success) { } successView: {
        YHSuccess()
    }
}

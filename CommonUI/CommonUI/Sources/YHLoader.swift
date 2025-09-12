import SwiftUI

public struct YHLoader: View {
    let state: LoadingState

    public var body: some View {
        switch state {
        case .success:
            YHSuccess()

        case .loading(let title):
            YHLoading(title: title)

        case .commonError(let errorDescription):
            YHCommonError(title: errorDescription)

        case .error404:
            YHError404()
        }
    }
}

// MARK: - Error
public extension YHLoader {
    enum LoadingState {
        case success(title: String)
        case loading(title: String)
        case commonError(title: String)
        case error404(title: String)
    }
}

#Preview {
    YHLoader(state: .success(title: "Успешный успех"))
}

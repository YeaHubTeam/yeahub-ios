import SwiftUI

public struct YHLoader: View {

    var state: LoadingState = .loading

    public var body: some View {
        switch state {
        case .success:
            YHSuccess()

        case .loading:
            YHLoading()

        case .commonError(let error):
            YHCommonError(title: error)

        case .error404:
            YHError404()
        }
    }
}

// MARK: - Error
extension YHLoader {
    enum LoadingState {
        case success
        case loading
        case commonError(title: String)
        case error404
    }
}

#Preview {
    YHLoader()
}

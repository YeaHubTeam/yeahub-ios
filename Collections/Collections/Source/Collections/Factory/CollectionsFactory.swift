import NavigationKit

public protocol CollectionsFactory {
    func makeCollectionsScreen(onSelectSpecializations: @escaping () -> Void) -> CollectionsViewController
}

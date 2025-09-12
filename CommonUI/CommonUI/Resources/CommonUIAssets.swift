import SwiftUI

public enum CommonUIAssets {
    private static let bundle = Bundle(for: BundleToken.self)

    public static func image(_ name: String) -> Image {
        Image(name, bundle: bundle)
    }
    
    public static let homeVCImageTabBarLogo = UIImage(named: "HomeIcon")
    public static let collectionsVCImageTabBarLogo = UIImage(named: "CollectionsIcon")
}

private final class BundleToken {}

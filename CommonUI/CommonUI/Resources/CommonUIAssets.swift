import SwiftUI

public enum CommonUIAssets {
    private static let bundle = Bundle(for: BundleToken.self)

    public static func image(_ name: String) -> Image {
        Image(name, bundle: bundle)
    }
}

private final class BundleToken {}

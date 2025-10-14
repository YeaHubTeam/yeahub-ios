import Foundation

extension String {
    
    public func localized(tableName: String = "Localizable", _ arguments: CVarArg...) -> String {
        let targetBundle = String.findBundleForLocalization(key: self, tableName: tableName)

        let localizedString = NSLocalizedString(self,
                                                tableName: tableName,
                                                bundle: targetBundle,
                                                comment: "")

        return arguments.isEmpty ? localizedString : String(format: localizedString, arguments: arguments)
    }

    private static func findBundleForLocalization(key: String, tableName: String) -> Bundle {
        let mainBundle = Bundle.main

        let candidates = Bundle.allBundles + Bundle.allFrameworks

        for bundle in candidates {
            if let identifier = bundle.bundleIdentifier, identifier.hasPrefix("com.apple.") {
                continue
            }

            let localizedString = bundle.localizedString(forKey: key,
                                                         value: nil,
                                                         table: tableName)
            if localizedString != key {
                return bundle
            }
        }
        return mainBundle
    }
}


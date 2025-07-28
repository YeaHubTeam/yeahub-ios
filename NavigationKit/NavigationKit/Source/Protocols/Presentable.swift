import UIKit

/// Describes object that can be presented in view hierarchy
public protocol Presentable: AnyObject {

    func toPresent() -> UIViewController?
}

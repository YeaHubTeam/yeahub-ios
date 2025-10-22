import Foundation
import UIKit


 public final class NavControllerWithHiddenStatusBar: UINavigationController {
    
     public override init(rootViewController: UIViewController) {
         super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
     
    public override var childForStatusBarHidden: UIViewController? {
        self.topViewController
    }
}

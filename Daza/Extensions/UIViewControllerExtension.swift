import UIKit

extension UIViewController {

    func trans(id: String) -> String {
        return NSLocalizedString(id, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }

}
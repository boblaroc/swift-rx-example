import Foundation
import UIKit
import RxSwift
import RxCocoa

extension UIButton {
    var rx_driveEnable: AnyObserver<Bool> {

        return UIBindingObserver(UIElement: self) { button, enabled in
            if enabled {
                button.backgroundColor = UIColor.exBlue
                button.isUserInteractionEnabled = true
            }
            else {
                button.backgroundColor = UIColor.exGrey
                button.isUserInteractionEnabled = false
            }
        }.asObserver()
    }
}

import Foundation
import UIKit

extension UIColor {

    //grey: #656565
    static var exGrey: UIColor {
        return UIColor(white:0.4, alpha:1.0)
    }

    // RED    HEX: #cf4040	R: 207	G: 64	B: 64	C: 0	M: 69	Y: 69	K: 19
    static var exRed: UIColor {
        return UIColor(red:0.81, green:0.25, blue:0.25, alpha:1.0)
    }

    //GREEN   HEX: #40cf88	R: 64	G: 207	B: 136	C: 69	M: 0	Y: 34	K: 19
    static var exGreen: UIColor {
        return UIColor(red:0.25, green:0.81, blue:0.53, alpha:1.0)
    }

    // BLUE   HEX: #4088cf	R: 64	G: 136	B: 207	C: 69	M: 34	Y: 0	K: 19
    static var exBlue: UIColor {
        return UIColor(red:0.25, green:0.53, blue:0.81, alpha:1.0)
    }
}

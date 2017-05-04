import Foundation
import UIKit

protocol PresenterProtocol {
    associatedtype ViewControllerType: UIViewController
    func makeViewController() -> ViewControllerType
}


import Foundation

protocol ViewModelDelegateProtocol {
}

protocol ViewModelProtocol {
    associatedtype DelegateType //: ViewModelDelegateProtocol
    var delegate: DelegateType { get }
    init(delegate: DelegateType)
}

class BaseViewModel<T> : ViewModelProtocol {
    let delegate: T
    required init(delegate: T) {
        self.delegate = delegate
    }
}

import Foundation
import RxSwift

extension DisposeBag {

    func dispose(_ disposables: [Disposable]) {
        disposables.forEach { [unowned self] disposable in
            self.insert(disposable)
        }
    }
}

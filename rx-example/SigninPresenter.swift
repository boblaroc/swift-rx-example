import Foundation
import UIKit
import RxSwift

struct SigninPresenter {

    fileprivate let datalayer: Datalayer

    init(datalayer: Datalayer) {
        self.datalayer = datalayer
    }
}

extension SigninPresenter: PresenterProtocol {

    func makeViewController() -> SigninViewController {
        let viewModel = SigninViewModel(delegate: self)
        let viewController = ViewControllerFactoryOf<SigninViewController>.make(with: viewModel)
        return viewController
    }
}

extension SigninPresenter: SigninViewModelDelegateProtocol {

    func signin(username: String, password: String) -> Observable<Void> {
        return datalayer
            .signin(username: username, password: password)
            .map { _ in return }
    }
}

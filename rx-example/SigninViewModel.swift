import Foundation
import RxSwift

protocol SigninViewModelDelegateProtocol: ViewModelDelegateProtocol {
    func signin(username: String, password: String) -> Observable<Void>
}

class SigninViewModel: BaseViewModel<SigninViewModelDelegateProtocol> {

    let disposeBag = DisposeBag()

    let username = Variable<String?>(nil)
    let password = Variable<String?>(nil)
    let error = Variable<String?>(nil)

    let signedIn = Variable<()>()

    // MARK: Sign In

    func signin() {

        guard let username = username.value, let password = password.value
            else { return }

        delegate.signin(username: username, password: password)
            .subscribe(onNext: onSignedIn, onError: onSignInError)
            .disposed(by: disposeBag)
    }

    private func onSignedIn() {
        signedIn.value = ()
    }

    private func onSignInError(_: Error) {
        error.value = "Error signing in"
    }


    // MARK: Validation

    var signInEnabled: Observable<Bool> {

        return Observable.combineLatest(username.asObservable(),
                                        password.asObservable(),
                                        resultSelector: inputIsValid)
    }

    private func inputIsValid(username: String?, password:String?) -> Bool {

        guard let username = username, let password = password
            else { return false }

        return !username.isEmpty && !password.isEmpty
    }
}

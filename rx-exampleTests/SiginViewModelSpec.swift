import Quick
import Nimble
import RxSwift
import RxTest

@testable import rx_example

class SigninViewModelTests: QuickSpec {

    class TestSigninVMDelegate: SigninViewModelDelegateProtocol {

        func signin(username: String, password: String) -> Observable<Void> {
            return Observable<()>.create { observer in

                if username.contains("beer") {
                    observer.onNext()
                    observer.onCompleted()
                } else {
                    observer.onError(datalayerError.signinFailed)
                }

                return Disposables.create()
            }
        }
    }

    override func spec() {

        describe("SigninViewModel") {
            let disposeBag = DisposeBag()
            var vm: SigninViewModel!

            beforeEach {
                vm = SigninViewModel(delegate: TestSigninVMDelegate())
            }

            context("Sign in behaviour") {
                it("should call sign in with good credentials") {

                    //arrange
                    vm.username.value = "beer"
                    vm.password.value = "password"
                    var b = false
                    vm.signedIn.asObservable().subscribe(onNext: { b = true }).dispose()

                    //action
                    vm.signInTapped.value = ()

                    //assert
                    expect(b).to(beTrue())
                }

                it("should display error with bad credentials") {

                    //arrange
                    vm.username.value = "bad credentials"
                    vm.password.value = "password"

                    //action
                    vm.signInTapped.value = ()

                    //assert
                    print("******* \(vm.error.value)")

                    expect(vm.error.value).toNot(beNil())
                }
            }

            context("SignIn Button Enabled State") {
                let isEnabled = Variable<Bool>(true)

                beforeEach {
                    (isEnabled <- vm.signInEnabled).disposed(by: disposeBag)
                }

                it("should be return false for signinEnabled after initialisation") {
                    expect(isEnabled.value).to(beFalse())
                }

                it("should be true for signInEnabled with good input") {
                    vm.username.value = "test"
                    vm.password.value = "password"
                    expect(isEnabled.value).to(beTrue())
                }
            }
        }
    }
}

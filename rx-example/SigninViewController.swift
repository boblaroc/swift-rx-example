import Foundation
import UIKit
import RxSwift
import RxCocoa

class SigninViewController: UIViewController, ViewControllerProtocol {
    typealias ViewModelType = SigninViewModel
    var viewModel: ViewModelType!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {

        disposeBag.dispose([
            viewModel.username <- usernameTextField.rx.text,
            viewModel.password <- passwordTextField.rx.text,
            errorLabel.rx.text <- viewModel.error,
            signinButton.rx_driveEnable <- viewModel.signInEnabled,
            viewModel.signInTapped <- signinButton.rx.tap,
            viewModel.signedIn.asObservable().subscribe(onNext: onSignedIn)
            ])
    }

    private func onSignedIn() {
        dismiss(animated: true, completion: nil)
    }
}

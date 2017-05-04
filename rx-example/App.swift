import Foundation
import UIKit

class App {

    class AppDatalayer: Datalayer {}

    private var window = UIWindow(frame: UIScreen.main.bounds)
    private let navigationController = UINavigationController(nibName: nil, bundle: nil)
    private let datalayer = AppDatalayer()

    init() {
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }

    func show() {
        let presenter = ListPresenter(navigationController: navigationController, beers: datalayer.requestAllBeers())

        navigationController.viewControllers = [presenter.makeViewController()]
        window.rootViewController = navigationController

        presentLogin()
    }

    private func presentLogin() {
        let presenter = SigninPresenter(datalayer: self.datalayer)
        window.rootViewController?
            .present(presenter.makeViewController(), animated: true, completion: nil)
    }
}

import Foundation
import UIKit
import RxSwift

struct ListPresenter {

    fileprivate let navigationController: UINavigationController

    let beers: Observable<[Beer]>

    init(navigationController: UINavigationController, beers: Observable<[Beer]>) {
        self.navigationController = navigationController
        self.beers = beers
    }
}

extension ListPresenter: PresenterProtocol {

    func makeViewController() -> ListViewController {

        let viewModel = ListViewModel(delegate: self)
        let viewController = ViewControllerFactoryOf<ListViewController>.make(with: viewModel)
        return viewController
    }
}

extension ListPresenter: ListViewModelDelegateProtocol {

    func showDetail(beers: Observable<[Beer]>, initialIndex: Int) {

        let presenter = DetailPresenter(beers: beers, initialIndex: initialIndex)
        navigationController.pushViewController(presenter.makeViewController(), animated: true)
    }
}

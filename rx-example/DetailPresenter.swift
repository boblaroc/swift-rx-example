import Foundation
import UIKit
import RxSwift

class DetailPresenter {

    fileprivate let disposeBag = DisposeBag()

    let beers: Observable<[Beer]>
    let initialIndex: Int
    init(beers: Observable<[Beer]>, initialIndex: Int) {
        self.beers = beers
        self.initialIndex = initialIndex
    }
}

extension DetailPresenter: PresenterProtocol {

    func makeViewController() -> DetailViewController {
        let viewModel = DetailViewModel(delegate: self)
        let viewController = ViewControllerFactoryOf<DetailViewController>.make(with: viewModel)
        return viewController
    }
}

extension DetailPresenter: DetailViewModelDelegateProtocol {

}

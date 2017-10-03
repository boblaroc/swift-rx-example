import Foundation
import RxSwift

protocol ListViewModelDelegateProtocol: ViewModelDelegateProtocol {
    var beers: Observable<[Beer]> { get }
    func showDetail(beers: Observable<[Beer]>, initialIndex: Int)
}

class ListViewModel: BaseViewModel<ListViewModelDelegateProtocol> {

    private let disposeBag = DisposeBag()

    let searchVariable = Variable<String?>("")

    func filteredBeers() -> Observable<[Beer]> {

        let search = searchVariable.asObservable()
        return Observable.combineLatest(delegate.beers, search, resultSelector: filterBeers)
    }

    func onItemTapped(index: Int) {
        delegate.showDetail(beers: filteredBeers(), initialIndex: index)
    }

    private func filterBeers(beers: [Beer], search: String?) -> [Beer] {

        guard let search = search else { return beers }
        return beers.filter {
            search.isEmpty || $0.name.lowercased().contains(search.lowercased())
        }
    }
}

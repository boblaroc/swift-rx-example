import Foundation
import RxSwift

protocol DetailViewModelDelegateProtocol: ViewModelDelegateProtocol {
    var beers: Observable<[Beer]> { get }
    var initialIndex: Int { get }
}

class DetailViewModel: BaseViewModel<DetailViewModelDelegateProtocol> {

    private let disposeBag = DisposeBag()
    private var index: Variable<Int>

    let name = Variable<String?>("")
    let style = Variable<String?>("")
    let brewry = Variable<String?>("")
    let abv = Variable<String?>("")
    let ibu = Variable<String?>("")
    let description = Variable<String?>("")
    let image = Variable<String>("no-image")

    let next = Variable<()>()
    let previous = Variable<()>()
    let nextEnabled = Variable<Bool>(true)
    let previousEnabled = Variable<Bool>(true)

    required init(delegate: DetailViewModelDelegateProtocol) {

        index = Variable<Int>(delegate.initialIndex)

        super.init(delegate: delegate)

        disposeBag.dispose([

            next.asObservable().subscribe(onNext: onNext),
            previous.asObservable().subscribe(onNext: onPrev),
            Observable
                .combineLatest(delegate.beers, index.asObservable(), resultSelector: selectBeer)
                .filter { $0 != nil }.map { $0! }
                .subscribe(onNext: renderBeer)
        ])
    }

    private func selectBeer(beers: [Beer], index: Int) -> Beer? {
        nextEnabled.value = index < beers.count-1
        previousEnabled.value = index > 0
        return beers.indices.contains(index) ? beers[index] : nil
    }

    private func renderBeer(beer: Beer) {
        name.value = beer.name.uppercased()
        style.value = beer.style.lowercased()
        brewry.value = beer.brewry
        abv.value = "ABV: \(beer.abv)%"
        ibu.value = "IBU: \(beer.ibu)"
        description.value = beer.description
        image.value = beer.image
    }

    private func onNext() { index.value += 1 }

    private func onPrev() { index.value -= 1 }
}

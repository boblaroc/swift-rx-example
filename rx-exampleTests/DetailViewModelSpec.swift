import Quick
import Nimble
import RxSwift
import RxTest

@testable import rx_example

class DetailViewModelTests: QuickSpec {

    class TestDetailVMDelegate: DetailViewModelDelegateProtocol {
        class Data: Datalayer{}
        var beers: Observable<[Beer]> { return Data().requestAllBeers() }
        var initialIndex: Int { return 0 }
    }

    override func spec() {
        describe("DetailViewModel") {
            context("Format") {

                it("should return formatted string for abv") {
                    let vm = DetailViewModel(delegate: TestDetailVMDelegate())

                    let abv = Variable<String?>("")
                    (abv <- vm.abv).dispose()

                    expect(abv.value?.hasPrefix("ABV:")).to(beTrue())
                }
            }

            context("Navigation") {

                it("should return false for previousEnabled after initialisation") {
                    let vm = DetailViewModel(delegate: TestDetailVMDelegate())

                    let enabled = Variable<Bool>(true)
                    (enabled <- vm.previousEnabled).dispose()

                    expect(enabled.value).to(beFalse())
                }

                it("should navigate to next beer onNext") {
                    let vm = DetailViewModel(delegate: TestDetailVMDelegate())

                    vm.onNext()

                    let name = Variable<String?>("")
                    (name <- vm.name).dispose()

                    expect(name.value).to(equal("PACIFIC ALE"))
                }
            }
        }
    }
}

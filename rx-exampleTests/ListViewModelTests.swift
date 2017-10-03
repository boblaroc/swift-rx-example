import Quick
import Nimble
import RxSwift
import RxTest

@testable import rx_example

class ListViewModelTests: QuickSpec {


    class TestListVMDelegate: ListViewModelDelegateProtocol {
        class Data: Datalayer{}

        var beers: Observable<[Beer]> { return Data().requestAllBeers() }
        func showDetail(beers: Observable<[Beer]>, initialIndex index: Int) {showDetailCalled = true }

        var showDetailCalled = false

    }

    override func spec() {

        describe("ListViewModel") {

             context("Filter") {

                it("should filter beer list") {
                    let vm = ListViewModel(delegate: TestListVMDelegate())

                    vm.searchVariable.value = "war"
                    let beers = Variable<[Beer]>([])
                    (beers <- vm.filteredBeers()).dispose()

                    expect(beers.value.count).to(equal(1))
                }
            }

            context("Navigation") {

                it("should call showDetail") {
                    let vm = ListViewModel(delegate: TestListVMDelegate())
                    vm.onItemTapped(index: 1)

                    expect((vm.delegate as! TestListVMDelegate).showDetailCalled).to(beTrue())
                }
            }
        }
    }
}

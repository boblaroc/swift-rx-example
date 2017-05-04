import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController, ViewControllerProtocol {

    typealias ViewModelType = ListViewModel
    var viewModel: ViewModelType!

    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()

        disposeBag.dispose([

            viewModel.itemTapped <- tableView.rx.itemSelected.map { $0.item },
            viewModel.searchVariable <- textView.rx.text,

            viewModel.filteredBeers()
                .debounce(0.3, scheduler: MainScheduler.instance)
                .bind(to: tableView.rx.items(
                    cellIdentifier: "Cell",
                    cellType: UITableViewCell.self),
                    curriedArgument: initialiseCell)
        ])
    }

    private func initialiseCell(row: Int, element: Beer, cell: UITableViewCell) {
        cell.textLabel?.text = element.name
        cell.imageView?.image = UIImage(named: element.image)!
    }
}

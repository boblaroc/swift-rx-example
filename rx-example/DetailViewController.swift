import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController, ViewControllerProtocol {

    typealias ViewModelType = DetailViewModel
    var viewModel: ViewModelType!

    let disposeBag = DisposeBag()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var brewryLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var ibuLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()

        disposeBag.dispose([
            nameLabel.rx.text <- viewModel.name,
            styleLabel.rx.text <- viewModel.style,
            brewryLabel.rx.text <- viewModel.brewry,
            abvLabel.rx.text <- viewModel.abv,
            ibuLabel.rx.text <- viewModel.ibu,
            descriptionTextView.rx.text <- viewModel.description,
            imageView.rx.image <- makeImage(image: viewModel.image),
            viewModel.next <- nextButton.rx.tap,
            nextButton.rx_driveEnable <- viewModel.nextEnabled,
            viewModel.previous <- previousButton.rx.tap,
            previousButton.rx_driveEnable <- viewModel.previousEnabled
        ])
    }

    private func makeImage(image: Variable<String>) -> Observable<UIImage?> {
        return image.asObservable().map { UIImage(named: $0) }
    }
}

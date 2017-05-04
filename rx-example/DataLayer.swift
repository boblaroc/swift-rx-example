import Foundation
import RxSwift

enum datalayerError: Error {
    case signinFailed
}

protocol Datalayer {
    func signin(username: String, password: String)-> Observable<User>
    func requestAllBeers() -> Observable<[Beer]>
    func requestBeer(id: Int) -> Observable<Beer?>
}

extension Datalayer {

    func signin(username: String, password: String)-> Observable<User> {
        return Observable<User>.create { observer in
            if username.contains("beer") {
                observer.onNext(User(name: username))
            } else {
                observer.onError(datalayerError.signinFailed)
            }
            return Disposables.create()
        }
    }

    func requestAllBeers() -> Observable<[Beer]> {

        let beers = JSONParser()
            .parseJSON(fileName: "beers")
            .map { beerJSON in
                Beer(id: beerJSON["id"] as! Int,
                     name: beerJSON["name"] as! String,
                     style: beerJSON["style"] as! String,
                     brewry: beerJSON["brewry"] as! String,
                     abv: beerJSON["abv"] as! Double,
                     ibu: beerJSON["ibu"] as! Double,
                     description: beerJSON["description"] as! String,
                     image: beerJSON["image"] as! String)
        }

        return Observable<[Beer]>.create { observer in
            observer.onNext(beers)
            return Disposables.create()
        }
    }

    func requestBeer(id: Int) -> Observable<Beer?> {
        return requestAllBeers().map { $0.first { $0.id == id } }
    }
}

class JSONParser {
    func parseJSON(fileName: String) -> Array<Dictionary<String, Any>> {
        let filePath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
        return json as! Array<Dictionary<String, Any>>
    }
}


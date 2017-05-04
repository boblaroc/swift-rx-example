import Foundation
import RxSwift
import RxCocoa


// Operator to bind Obserer<T> to Observable<T>
// LHS: Obserer
// RHS: Observable

infix operator <-

func <- <T>(observer: Variable<T>, variable: Variable<T>) -> Disposable {
    return variable.asObservable().bind(to: observer)
}

func <- <T>(observer: Variable<T>, observable: Observable<T>) -> Disposable {
    return observable.bind(to: observer)
}

func <- <T>(variable: Variable<T>, property: ControlProperty<T>) -> Disposable {
    return property.bind(to: variable)
}

func <- <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    return variable.asObservable().bind(to: property)
}

func <- <T>(property: ControlProperty<T>, variable: Observable<T>) -> Disposable {
    return variable.bind(to: property)
}

func <- <T>(variable: Variable<T>, event: ControlEvent<T>) -> Disposable {
    return event.bind(to: variable)
}

func <- <U, T>(observer: UIBindingObserver<U, T>, variable: Variable<T>) -> Disposable {
    return variable.asObservable().bind(to: observer)
}

func <- <U, T>(observer: UIBindingObserver<U, T>, observable: Observable<T>) -> Disposable {
    return observable.bind(to: observer)
}

func <- <T>(observer: AnyObserver<T>, variable: Variable<T>) -> Disposable {
    return variable.asObservable().bind(to: observer)
}

func <- <T>(observer: AnyObserver<T>, observable: Observable<T>) -> Disposable {
    return observable.bind(to: observer)
}

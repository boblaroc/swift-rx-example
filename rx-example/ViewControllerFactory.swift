//
//  UIViewControllerExtension.swift
//  property-platform-ios
//
//  Created by Sam Saito on 2/27/17.
//  Copyright © 2017 REA Group. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol: class {
    associatedtype ViewModelType
    static var typeDescription: String { get }
    var viewModel: ViewModelType! { get set }
    func recieve(viewModel: ViewModelType)
}

extension ViewControllerProtocol where Self: UIViewController {

    static var typeDescription: String {
        return String(describing: self)
    }

    func recieve(viewModel: ViewModelType) {
        guard self.viewModel == nil else {
            fatalError("You are not allowed to set a view model more than once.")
        }
        self.viewModel = viewModel
    }
}

fileprivate struct Storyboard {

    fileprivate static func instance(for viewControllerType: String) -> UIStoryboard {
        return UIStoryboard(name: viewControllerType, bundle: Bundle.main)
    }
}

struct ViewControllerFactoryOf<T: ViewControllerProtocol> where T: UIViewController {

    private init() { } // At some point this should become an actual injectable object so that the work can
    // only happen in places where it *needs* to happen.

    static func make(with viewModel: T.ViewModelType) -> T {
        guard let rawViewController = Storyboard.instance(for: T.typeDescription).instantiateInitialViewController() else {
            fatalError("Couldn't find a storyboard for \(T.typeDescription)")
        }

        guard let viewController = rawViewController as? T else {
            fatalError("Couldn't turn `rawViewController` into `UIViewController` of requested type.")
        }

        viewController.recieve(viewModel: viewModel)

        return viewController
    }
}

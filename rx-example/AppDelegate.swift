//
//  AppDelegate.swift
//  rx-example
//
//  Created by Rob Ciolli on 4/9/17.
//  Copyright © 2017 Rob Ciolli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let app = App()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        app.show()
        return true
    }
}


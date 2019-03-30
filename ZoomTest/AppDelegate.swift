//
//  AppDelegate.swift
//  ZoomTest
//
//  Created by Venkat Rao on 2/17/19.
//  Copyright © 2019 Venkat Rao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: FullScreenImageViewController())
        window?.makeKeyAndVisible()

        return true
    }
}

//
//  AppDelegate.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .mainBGColor
        let vc = SearchHistoryViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

}


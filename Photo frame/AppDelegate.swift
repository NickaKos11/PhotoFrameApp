//
//  AppDelegate.swift
//  Photo frame
//
//  Created by Костина Вероника  on 08.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController: UIViewController
        let appCoordinator = AppCoordinator()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        viewController = appCoordinator.photoPickerController
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        return true
    }
}


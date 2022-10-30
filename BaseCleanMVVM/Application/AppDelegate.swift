//
//  AppDelegate.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 10/10/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppAppearance.setupAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController, appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}


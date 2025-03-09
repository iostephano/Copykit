//
//  AppDelegate.swift
//  CopyKit
//
//  Created by Stephano Portella on 5/03/25.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
         return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}


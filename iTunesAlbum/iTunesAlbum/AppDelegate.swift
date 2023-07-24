//
//  AppDelegate.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 13.0, *) {
            // In iOS 13, the window setup is done in the SceneDelegate.
        }
        else {
            // For iOS versions below 13:
            window = UIWindow(frame: UIScreen.main.bounds)
            let albumListViewController = AlbumListViewController(nibName: "AlbumListViewController", bundle: nil)
            window?.rootViewController = UINavigationController(rootViewController: albumListViewController)
            window?.makeKeyAndVisible()
        }
        
        return true
    }

    // MARK: - UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

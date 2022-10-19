//
//  AppDelegate.swift
//  Instagram
//
//  Created by Jay on 2022/10/13.
//

import UIKit
import Parse
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "yT398IyNtwiyAmvtC82kg50hs2yl20shna0Kyp4A" // <- UPDATE
            $0.clientKey = "au8DGzHvRo6QITBUVgxtXAmKsQt1jaanLIjDCNI9" // <- UPDATE
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        if PFUser.current() != nil{
            let main = UIStoryboard(name: "Main", bundle: nil)
            let homeViewNavicationController = main.instantiateViewController(withIdentifier: "HomeViewNavicationController")
            window?.rootViewController = homeViewNavicationController
        }
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}


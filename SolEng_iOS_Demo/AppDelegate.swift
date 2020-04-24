//
//  AppDelegate.swift
//  SolEng_iOS_Demo
//
//  Created by YongjunChoi on 2020/03/16.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import UIKit
import CallKit
import PushKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var voipRegistry: PKPushRegistry?
    
    lazy var provider: CXProvider = {
        let provider = CXProvider.default
        provider.setDelegate(self, queue: .main)
        return provider
    }()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // If granted comes true you can enabled features based on authorization.
            guard granted else { return }
            application.registerForRemoteNotifications()
        }
        return true
    }

    // MARK: register remote notification
    private func application(application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        //send this device token to server
        print("didRegisterForRemoteNotificationsWithDeviceToken")

        let token = deviceToken as Data
        if UserDefaults.standard.pushToken != token {
            UserDefaults.standard.pushTokenChange = true
            UserDefaults.standard.pushToken = token
        }
    }

    //Called if unable to register for APNS.
    private func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("didFailToRegisterForRemoteNotificationsWithError")
    }

    // MARK: UISceneSession Lifecycle
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


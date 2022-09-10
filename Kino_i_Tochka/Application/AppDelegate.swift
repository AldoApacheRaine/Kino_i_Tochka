//
//  AppDelegate.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit
import RealmSwift
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let authService = AppAuthService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        authService.vkSdkInit(uiDelegate: self, handler: self)
        let config = Realm.Configuration(
          schemaVersion: 0,
          deleteRealmIfMigrationNeeded: true
        )
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
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

extension AppDelegate: VKSdkUIDelegate{
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window?.rootViewController?.show(controller, sender: nil)
        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}

extension AppDelegate: AppAuthServiceSessionHandler {
    
    func onWakeupSession() {
    }
    
    func onWakeupSessionFailed() {
    }
}





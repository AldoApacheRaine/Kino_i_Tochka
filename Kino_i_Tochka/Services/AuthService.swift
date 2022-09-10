//
//  AuthService.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 10.09.2022.
//

import Foundation
import VK_ios_sdk

protocol AppAuthServiceSessionHandler {
    func onWakeupSession()
    func onWakeupSessionFailed()
}

class AppAuthService: NSObject {

    private let appId = "8232649"
    private var handler: AppAuthServiceSessionHandler? = nil
    let defaults = UserDefaults.standard
    
    func vkSdkInit( uiDelegate: VKSdkUIDelegate?, handler: AppAuthServiceSessionHandler ) {
        self.handler = handler
        let vkSdk = VKSdk.initialize(withAppId: appId)
        vkSdk?.register(self)
        vkSdk?.uiDelegate = uiDelegate
        print("ВК инициализация...")
        wakeUpSession()
    }
    
    private func wakeUpSession() {
        let scope =  ["wall", "photos"]
        VKSdk.wakeUpSession(scope) {state, error in
            if state == VKAuthorizationState.authorized {
                self.handler?.onWakeupSession()
                self.getInfoUser()
            } else {
                self.handler?.onWakeupSessionFailed()
            }
        }
    }
}

extension AppAuthService: VKSdkDelegate  {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            getInfoUser()

//            NotificationCenter.default.post(name: Notification.Name("buttonsState"), object: nil)
//            authVKButton.isHidden = true
//            unloginVKButton.isHidden = false
        }
    }
    
    private func getInfoUser() {
        guard let request = VKRequest(method: "users.get", parameters: ["fields":"photo_200"]) else { return }
        request.execute(resultBlock: { [unowned self]
            (response) in
            guard let user = response?.json as? NSArray else { return }
            let userParams = user[0] as? NSDictionary
            let name = userParams?["first_name"] as? String ?? ""
            let surname = userParams?["last_name"] as? String ?? ""
            let photoUrl = userParams?["photo_200"] as? String ?? ""
            defaults.set(name, forKey: KeysDefaults.firstName)
            defaults.set(surname, forKey: KeysDefaults.lastName)
            defaults.set(photoUrl, forKey: KeysDefaults.photo)
            NotificationCenter.default.post(name: .onProfileUpdate, object: user)
        }, errorBlock: {
            (error) in
            NotificationCenter.default.post(name: .onProfileUpdate, object: nil)
            print(error as Any)
        })
    }
    
    func vkSdkUserAuthorizationFailed() {
        NotificationCenter.default.post(name: .onProfileUpdate, object: nil)
        print(#function)
    }
}

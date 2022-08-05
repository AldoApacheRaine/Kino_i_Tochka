//
//  ProfileViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 03.08.2022.
//

import UIKit
import VK_ios_sdk

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileSurnameLabel: UILabel!
    @IBOutlet weak var authVKButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var unloginVKButton: UIButton!
    
    private let appId = "8232649"
    var profileData: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkSdkInit()
        wakeUpSession()
        setNavigationBar()
        
    }
    override func viewDidLayoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    @IBAction func authButtonTapped(_ sender: Any) {
        vkAuthorize()
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
    }
    
    @IBAction func unloginButtonTapped(_ sender: Any) {
        VKSdk.forceLogout()
        profileNameLabel.text = "Имя"
        profileSurnameLabel.text = "Фамилия"
        profileImageView.image = UIImage(systemName: "person.fill")
        authVKButton.isHidden = false
    }
    
    private func vkSdkInit() {
        let vkSdk = VKSdk.initialize(withAppId: appId)
        vkSdk?.register(self)
        vkSdk?.uiDelegate = self
        print("ВК инициализация...")
    }
    
    private func wakeUpSession() {
        let scope =  ["wall", "photos"]
        VKSdk.wakeUpSession(scope) { [self] state, error in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                getInfoUser()
                authVKButton.isHidden = true
            } else {
                print("Проблема авторизации state \(state) error \(String(describing: error))")
            }
        }
    }
    
    private func vkAuthorize() {
        let scope =  ["wall", "photos"]
        VKSdk.wakeUpSession(scope) { state, error in
            if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("Проблема авторизации state \(state) error \(String(describing: error))")
            }
        }
    }
    
    private func getInfoUser() {
        guard let request = VKRequest(method: "users.get", parameters: ["fields":"photo_200"]) else { return }
        request.execute(resultBlock: {
            (response) in
            guard let user = response?.json as? NSArray else { return }
            let userParams = user[0] as? NSDictionary
            let name = userParams?["first_name"] as? String ?? ""
            let surname = userParams?["last_name"] as? String ?? ""
            let photoUrl = userParams?["photo_200"] as? String ?? ""
            self.profileData = (Profile(first_name: name, last_name: surname, photo_200: photoUrl))
//            print(self.profileData)
            self.setProfileInfo()
        }, errorBlock: {
            (error) in
            print(error as Any)
        })
    }
    
    private func setProfileInfo() {
        profileNameLabel.text = profileData?.first_name
        profileSurnameLabel.text = profileData?.last_name
        profileImageView.setImageFromUrl(imageUrl: profileData?.photo_200 ?? "")
    }
}

// MARK: - VKSdkDelegate

extension ProfileViewController: VKSdkDelegate, VKSdkUIDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            getInfoUser()
            authVKButton.isHidden = true
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
// MARK: - VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        self.present(controller, animated: true, completion: nil)

    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}

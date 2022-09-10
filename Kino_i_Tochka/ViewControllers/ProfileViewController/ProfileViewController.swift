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
        
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLogged()
        setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(onProfileUpdate(_:)), name: .onProfileUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func onProfileUpdate(_ n: Notification) {
        setProfileInfo()
        authVKButton.isHidden = true
        unloginVKButton.isHidden = false
        
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
        resetDefaults()
        profileNameLabel.text = "Имя"
        profileSurnameLabel.text = "Фамилия"
        profileImageView.image = UIImage(named: "emptyProfile")
        authVKButton.isHidden = false
        unloginVKButton.isHidden = true
    }
    
    private func isLogged() {
        if VKSdk.isLoggedIn() {
            setProfileInfo()
            authVKButton.isHidden = true
        } else {
            unloginVKButton.isHidden = true
        }
    }
    
    private func vkAuthorize() {
        let scope =  ["wall", "photos"]
        VKSdk.wakeUpSession(scope) { state, error in
            if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("VKAutorize Проблема авторизации state \(state) error \(String(describing: error))")
            }
        }
    }
    
    private func setProfileInfo() {
        profileNameLabel.text = defaults.string(forKey: KeysDefaults.firstName)
        profileSurnameLabel.text = defaults.string(forKey: KeysDefaults.lastName)
        profileImageView.setImageFromUrl(imageUrl: (defaults.string(forKey: KeysDefaults.photo)) ?? "")
    }
    
    private func resetDefaults() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}


//
//  FavoritesViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 09.07.2022.
//

import UIKit
import RealmSwift
import VK_ios_sdk

class FavoritesViewController: UIViewController {
    
    private let appId = "8232649"
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var noFilmImageView: UIImageView!
    
    
    let movieCell = MovieTableViewCell()
    
    private let localRealm = try! Realm()
    var realmMovieArray: Results<RealmMovie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkSdkInit()
        realmMovieArray = localRealm.objects(RealmMovie.self)
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoritesTableView.reloadData()

    }
    
    @IBAction func singInVK() {
        print("Вход в ВК")
        wakeUpSession()
    }
    
    private func wakeUpSession() {
        let scope =  ["wall", "photos"]
        VKSdk.wakeUpSession(scope) { [self] state, error in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                checkFavorites()
//                getInfoUser()
                getPictureUser()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("Проблема авторизации state \(state) error \(String(describing: error))")
            }
        }
    }
    
    private func vkSdkInit() {
        let vkSdk = VKSdk.initialize(withAppId: appId)
        vkSdk?.register(self)
        vkSdk?.uiDelegate = self
        print("ВК инициализация...")
    }
    
//    private func getInfoUser() {
//        guard let request = VKRequest(method: "account.getProfileInfo", parameters: ["first_name": "last_name"]) else { return }
//        request.execute(resultBlock: {
//            (response) in
//            print(response?.json as Any)
//        }, errorBlock: {
//            (error) in
//            print(error as Any)
//        })
//    }
    
    private func getPictureUser() {
        guard let request = VKRequest(method: "users.get", parameters: ["fields":"photo_200"]) else { return }
        request.execute(resultBlock: {
            (response) in
            print(response?.json as Any)
        }, errorBlock: {
            (error) in
            print(error as Any)
        })
    }
    
    private func setTableView() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.isHidden = true
    }
    
    func checkFavorites() {
        if realmMovieArray.isEmpty {
            favoritesTableView.isHidden = true
            noFilmImageView.isHidden = false
        } else {
            favoritesTableView.isHidden = false
            noFilmImageView.isHidden = true
            favoritesTableView.reloadData()
        }
    }
}

// MARK: - VKSdkDelegate

extension FavoritesViewController: VKSdkDelegate, VKSdkUIDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
        checkFavorites()
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
    
    
}

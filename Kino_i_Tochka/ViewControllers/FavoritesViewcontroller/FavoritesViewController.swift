//
//  FavoritesViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 09.07.2022.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
        
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var noFilmImageView: UIImageView!
    
    
    let movieCell = MovieTableViewCell()
    
    private let localRealm = try! Realm()
    var realmMovieArray: Results<RealmMovie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmMovieArray = localRealm.objects(RealmMovie.self)
        setTableView()
        checkFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoritesTableView.reloadData()

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

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
    
    private let localRealm = try! Realm()
    var realmMovieArray: Results<RealmMovie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmMovieArray = localRealm.objects(RealmMovie.self)
        setTableView()
        checkFavorites()
        SpotlightManager.setupSpotlight(with: Array(realmMovieArray), and: "Избранные фильмы")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailFavoritesViewController {
            if let cell = sender as? FavoritesTableViewCell, let index = favoritesTableView.indexPath(for: cell)?.row{
                destinationViewController.filmId = realmMovieArray[index].realmId
            }
        }
    }
}

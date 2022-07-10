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
    let movieCell = MovieTableViewCell()
    
    private let localRealm = try! Realm()
    private var realmMovieArray: Results<RealmMovie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmMovieArray = localRealm.objects(RealmMovie.self)
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoritesTableView.reloadData()
    }
    
    private func setTableView() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realmMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell") as? FavoritesTableViewCell {
            let model = realmMovieArray[indexPath.row]
            cell.cellConfigure(model: model)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let deleteModel = realmMovieArray[indexPath.row]
        RealmManager.shared.deleteRealmModel(model: deleteModel)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
//        print(realmMovieArray)
    }
}

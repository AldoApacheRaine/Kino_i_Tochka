//
//  FavoritesViewController + UITableView.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 23.07.2022.
//

import Foundation
import UIKit

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
        checkFavorites()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailFavoritesViewController {
            if let cell = sender as? FavoritesTableViewCell, let index = favoritesTableView.indexPath(for: cell)?.row{
                destinationViewController.realmMovie = realmMovieArray[index]
            }
        }
    }
}

//
//  DetailFavoritesViewController + UICollectionView.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 05.08.2022.
//

import Foundation
import UIKit

extension DetailFavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genresCollectionView {
            return realmMovie?.genres.count ?? 0
        }
        return realmMovie?.realmPersonName.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genresCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genresFavoritesCell", for: indexPath) as? GenresFavoritesCollectionViewCell {
                cell.genreLabel.text = realmMovie?.genres[indexPath.item]
                return cell
            }
            return UICollectionViewCell()
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesPersonCell", for: indexPath) as? PersonsFavoritesCollectionViewCell {
            if let realmMovie = realmMovie {
            cell.cellConfugure(detail: realmMovie, index: indexPath.item)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

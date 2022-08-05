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
        return realmMovie?.genres.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genresFavoritesCell", for: indexPath) as? GenresFavoritesCollectionViewCell {
            cell.genreLabel.text = realmMovie?.genres[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
}

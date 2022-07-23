//
//  DetailViewController + UICollectionView.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 23.07.2022.
//

import Foundation
import UIKit

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == personsCollectionView {
            return movieData?.persons.count ?? 0
        }
        return movieData?.genres.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == personsCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as? PersonCollectionViewCell {
                cell.cellConfugure(detail: (movieData?.persons[indexPath.row])!)
                return cell
            }
            return UICollectionViewCell()
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genresCell", for: indexPath) as? GenresCollectionViewCell {
            cell.genreLabel.text = movieData?.genres[indexPath.item].name
            return cell
        }
        return UICollectionViewCell()
    }
}



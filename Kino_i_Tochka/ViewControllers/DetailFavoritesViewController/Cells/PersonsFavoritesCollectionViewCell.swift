//
//  PersonsFavoritesCollectionViewCell.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 31.08.2022.
//

import UIKit

class PersonsFavoritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personDescriptionLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfugure(detail: RealmMovie, index: Int) {
        if detail.realmPersonDescription[index] == "Unknown" || detail.realmPersonDescription[index] == nil {
            personDescriptionLabel.text = detail.realmPersonEnProfession[index]
        } else {
            personDescriptionLabel.text = detail.realmPersonDescription[index]
        }
        personNameLabel.text = detail.realmPersonName[index]
        personImageView.setImageFromUrl(imageUrl: detail.realmPersonPhoto[index])
    }
}

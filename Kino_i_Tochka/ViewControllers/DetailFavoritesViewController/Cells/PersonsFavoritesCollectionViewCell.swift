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
    
//    func cellConfugure(detail: RealmMovie) {
//        if detail.realmPersonDescription == "Unknown" {
//            personDescriptionLabel.text = detail.realmPersonEnProfession
//        } else {
//            personDescriptionLabel.text = detail.realmPersonDescription
//        }
//        
//        personNameLabel.text = detail.realmPersonName
//        personImageView.setImageFromUrl(imageUrl: detail.realmPersonPhoto)
//    }
}

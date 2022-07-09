//
//  PersonCollectionViewCell.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 03.07.2022.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personDescriptionLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfugure(detail: Persons){
        if let description = detail.description {
            personDescriptionLabel.text = description
        } else {
            personDescriptionLabel.text = detail.enProfession
        }
        
        personNameLabel.text = detail.name
        personImageView.setImageFromUrl(imageUrl: detail.photo)
    }
}

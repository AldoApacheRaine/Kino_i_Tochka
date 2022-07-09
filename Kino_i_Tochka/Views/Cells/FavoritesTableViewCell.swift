//
//  FavoritesTableViewCell.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 09.07.2022.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var favoritesRatingLabel: UILabel!
    @IBOutlet weak var favoritesLenghtLabel: UILabel!
    @IBOutlet weak var favoritesYearLabel: UILabel!
    @IBOutlet weak var favoritesNameLabel: UILabel!
    @IBOutlet weak var favoritesImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellConfigure(model: RealmMovie) {
        favoritesNameLabel.text = model.realmName
        favoritesYearLabel.text = String(model.realmYear)
        
        let (hour, min) = { (mins: Int) -> (Int, Int) in
            return (mins / 60, mins % 60)}(model.realmMovieLenght)
        
        favoritesLenghtLabel.text = "\(hour) ч \(min) мин"
        favoritesRatingLabel.text = String(model.realmRatingKp)
        favoritesImageView.setImageFromUrl(imageUrl: model.realmPosterUrl)
    }

}

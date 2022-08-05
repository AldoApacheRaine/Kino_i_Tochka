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
    @IBOutlet weak var favoritesStarRatingStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for case let view as UIImageView in favoritesStarRatingStack.subviews {
            view.image = (UIImage(systemName: "star"))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellConfigure(model: RealmMovie) {
        favoritesNameLabel.text = model.realmName
        favoritesYearLabel.text = String(model.realmYear)
        
        let (hour, min) = model.realmMovieLenght.convertMinutes()
        
        favoritesLenghtLabel.text = "\(hour) ч \(min) мин"
        favoritesRatingLabel.text = String(model.realmRatingKp)
        favoritesImageView.setImageFromUrl(imageUrl: model.realmPosterUrl)
        
        let checkedStars = Int((model.realmRatingKp - 1) / 2)
        for i in 0...checkedStars {
            if let image = favoritesStarRatingStack.subviews[i] as? UIImageView {
                image.image = UIImage(systemName: "star.fill")
            }
        }
    }

}

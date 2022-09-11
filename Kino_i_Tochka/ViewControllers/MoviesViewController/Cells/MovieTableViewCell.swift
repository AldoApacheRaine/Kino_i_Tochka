//
//  MovieTableViewCell.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit
import RealmSwift

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieLikeButton: UIButton!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieLenghtLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieRetingStarStack: UIStackView!
    
    private let localRealm = try! Realm()
    
    func cellConfigure(_ movieData: Doc) {
        
        if let name = movieData.name {
            movieNameLabel.text = name
        } else {
            movieNameLabel.text = "No data"
        }
        
        movieYearLabel.text = String(movieData.year)
        movieRatingLabel.text = String(movieData.rating.kp)
        
        let reamlResult = localRealm.objects(RealmMovie.self).where { $0.realmId == movieData.id }
        
        if reamlResult.first?.realmId == movieData.id {
                movieLikeButton.tintColor = .red
            }
        
        let (hour, min) = (movieData.movieLength ?? 0).convertMinutes()
        
        movieLenghtLabel.text = "\(hour) ч \(min) мин"
        
        moviePosterImageView.setImageFromUrl(imageUrl: movieData.poster.url)
        
        let checkedStars = Int((movieData.rating.kp - 1) / 2)
        for i in 0...checkedStars {
            if let image = movieRetingStarStack.subviews[i] as? UIImageView {
                image.image = UIImage(systemName: "star.fill")
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for case let view as UIImageView in movieRetingStarStack.subviews {
            view.image = (UIImage(systemName: "star"))
        }
        movieLikeButton.tintColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func movieLikeButtonTapped(_ sender: Any) {
        print("TAPPED")
    }
}

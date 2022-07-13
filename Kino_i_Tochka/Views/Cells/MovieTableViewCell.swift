//
//  MovieTableViewCell.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit
import RealmSwift

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieLenghtLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieRetingStarStack: UIStackView!
    
    private let localRealm = try! Realm()
    private var realmMovieArray: Results<RealmMovie>!
    var realmIdArray: [Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        realmMovieArray = localRealm.objects(RealmMovie.self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for case let view as UIImageView in movieRetingStarStack.subviews {
            view.image = (UIImage(systemName: "star"))
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        print("Like Tapped")
    }
    
    func cellConfugure(movie: Doc){
        if let name = movie.name {
            movieNameLabel.text = name
        } else {
            movieNameLabel.text = "No data"
        }
        
        movieYearLabel.text = String(movie.year)
        movieRatingLabel.text = String(movie.rating.kp)
        
        for i in realmMovieArray {
            if !realmIdArray.contains(i.realmId) {
                realmIdArray.append(i.realmId)
            }
        }
        
        if realmIdArray.contains(movie.id) {
            favoritesButton.tintColor = .red
            print(realmMovieArray)
            print(realmIdArray)
        } else {
            favoritesButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        let (hour, min) = (movie.movieLength ?? 0).convertMinutes()
        
        movieLenghtLabel.text = "\(hour) ч \(min) мин"
        
        moviePosterImageView.setImageFromUrl(imageUrl: movie.poster.url)
        
        let checkedStars = Int((movie.rating.kp - 1) / 2)
        for i in 0...checkedStars {
            if let image = movieRetingStarStack.subviews[i] as? UIImageView {
                image.image = UIImage(systemName: "star.fill")
            }
        }
    }
}

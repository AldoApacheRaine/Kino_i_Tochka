//
//  MovieTableViewCell.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit
import RealmSwift

protocol SaveRealmDelegate: AnyObject {
    func saveModel(movieData: Doc)
}
protocol DelRealmDelegate: AnyObject {
    func delModel(movieData: Doc)
}

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieLikeButton: UIButton!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieLenghtLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieRetingStarStack: UIStackView!
    
    weak var saveDelegate: SaveRealmDelegate?
    weak var delDelegate: DelRealmDelegate?
    
    private let localRealm = try! Realm()
    var buttonSwitched : Bool = false


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
    
    var favButtonPressed : (() -> ()) = {}
    
    @IBAction func movieLikeButtonTapped(_ sender: Any) {
        print("TAPPED")
        favButtonPressed()
    }
    
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
                buttonSwitched = true
        } else {
            buttonSwitched = false
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
    
    func saveAndDelRealmModel(_ movie: Doc) {
        buttonSwitched = !buttonSwitched
        if buttonSwitched {
            self.saveDelegate?.saveModel(movieData: movie)
            
//            let realmMovie = RealmMovie()
//            realmMovie.realmName = movie.name ?? "Unknown"
//            realmMovie.realmDescription = movie.description ?? "Unknown"
//            realmMovie.realmId = movie.id
//            realmMovie.realmMovieLenght = movie.movieLength ?? 00
//            realmMovie.realmPosterUrl = movie.poster.url
//            realmMovie.realmYear = movie.year
//            realmMovie.realmRatingKp = movie.rating.kp
//            Network.network.getMovieDetails(id: movie.id) { (detail: DetailMovie) in
//                for i in 0...(detail.genres.count) - 1 {
//                    realmMovie.genres.append(detail.genres[i].name)
//                }
//
//                for i in 0...(detail.persons.count) - 1 {
//                    realmMovie.realmPersonName.append(detail.persons[i].name)
//                    realmMovie.realmPersonPhoto.append(detail.persons[i].photo)
//                    realmMovie.realmPersonEnProfession.append(detail.persons[i].enProfession)
//                    realmMovie.realmPersonDescription.append(detail.persons[i].description)
//                }
//            }
//            RealmManager.shared.saveRealmModel(model: realmMovie)
            movieLikeButton.tintColor = .red
        } else {
            self.delDelegate?.delModel(movieData: movie)
//
//            let reamlResult = localRealm.objects(RealmMovie.self).where { $0.realmId == movie.id }
//                if let realmMovie = reamlResult.first {
//                    RealmManager.shared.deleteRealmModel(model: realmMovie)
//                }
                movieLikeButton.tintColor = .white
                
            }
        }
        //
        
        
        
    }



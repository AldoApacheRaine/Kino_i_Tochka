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
    
    private let localRealm = try! Realm()
    private var realmMovieArray: Results<RealmMovie>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        realmMovieArray = localRealm.objects(RealmMovie.self)
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
//            print(i.realmId)
            if i.realmId == movie.id {
                favoritesButton.tintColor = .red
//                print("Realm id - \(realmMovieArray[i].realmId)")
//                print("Cell id - \(movie.id)")

            }
        }
        
        let (hour, min) = { (mins: Int) -> (Int, Int) in
            return (mins / 60, mins % 60)}(movie.movieLength ?? 0)
        
        movieLenghtLabel.text = "\(hour) ч \(min) мин"
        
        moviePosterImageView.setImageFromUrl(imageUrl: movie.poster.url)
    }
}

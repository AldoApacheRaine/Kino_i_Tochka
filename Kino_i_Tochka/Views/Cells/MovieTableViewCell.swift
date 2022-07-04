//
//  MovieTableViewCell.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
//    @IBOutlet weak var movieLenghtLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        
//        if let lenght = movie.movieLength {
//            movieLenghtLabel.text = String(lenght)
//        } else {
//            movieLenghtLabel.text = "no data"
//        }
        
        moviePosterImageView.setImageFromUrl(imageUrl: movie.poster.url)
    }
}

//
//  MovieTableViewCell.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit
import RealmSwift

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieLikeImage: UIImageView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieLenghtLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieRetingStarStack: UIStackView!
    
    private let localRealm = try! Realm()
    
    weak var viewModel: MoviesCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            if let name = viewModel.name {
                movieNameLabel.text = name
            } else {
                movieNameLabel.text = "No data"
            }
            
            movieYearLabel.text = String(viewModel.year)
            movieRatingLabel.text = String(viewModel.rating)
            
            let reamlResult = localRealm.objects(RealmMovie.self).where { $0.realmId == viewModel.id }
            
            if reamlResult.first?.realmId == viewModel.id {
                    movieLikeImage.tintColor = .red
                }
            
            let (hour, min) = (viewModel.movieLength ?? 0).convertMinutes()
            
            movieLenghtLabel.text = "\(hour) ч \(min) мин"
            
            moviePosterImageView.setImageFromUrl(imageUrl: viewModel.poster)
            
            let checkedStars = Int((viewModel.rating - 1) / 2)
            for i in 0...checkedStars {
                if let image = movieRetingStarStack.subviews[i] as? UIImageView {
                    image.image = UIImage(systemName: "star.fill")
                }
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
        movieLikeImage.tintColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

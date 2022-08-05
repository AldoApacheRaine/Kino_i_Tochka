//
//  DetailFavoritesViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 05.08.2022.
//

import UIKit
import RealmSwift
import VK_ios_sdk

class DetailFavoritesViewController: UIViewController {
    @IBOutlet weak var detailBackImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailYearLabel: UILabel!
    @IBOutlet weak var detailLenghtLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var detailRatingStarStack: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let localRealm = try! Realm()
    var realmMovie: RealmMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetails()
        setGenresCollection()
        
        scrollView.delegate = self
    }
    

    
    private func setGenresCollection() {
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
    }

    
    private func setDetails() {
        detailNameLabel.text = realmMovie?.realmName
        detailYearLabel?.text = String(realmMovie?.realmYear ?? 0)
        detailDescriptionLabel.text = realmMovie?.realmDescription
        detailRatingLabel.text = String(realmMovie?.realmRatingKp ?? 0)
        detailBackImageView.setImageFromUrl(imageUrl: (realmMovie?.realmPosterUrl)!)
        let (hour, min) = (realmMovie?.realmMovieLenght ?? 0).convertMinutes()
        detailLenghtLabel.text = "\(hour) ч \(min) мин"
        let checkedStars = Int (((realmMovie?.realmRatingKp ?? 0) - 1) / 2)
        for i in 0...checkedStars {
            if let image = detailRatingStarStack.subviews[i] as? UIImageView {
                image.image = UIImage(systemName: "star.fill")
            }
        }
    }
}

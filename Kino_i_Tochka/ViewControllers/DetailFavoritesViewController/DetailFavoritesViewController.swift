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
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var personsCollectionView: UICollectionView!
    
    private let localRealm = try! Realm()
    internal var realmMovie: RealmMovie?
    var filmId: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reamlResult = localRealm.objects(RealmMovie.self).where { $0.realmId == filmId }
        if reamlResult.isEmpty  {
            navigationController?.popViewController(animated: true)
        }
        realmMovie = reamlResult.first
        setDetails()
        setGenresCollection()
        setPersonCollection()
        scrollView.delegate = self
        setShareButton()
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        let shareController = VKShareDialogController()
        shareController.text = realmMovie?.realmName
        shareController.uploadImages = [VKUploadImage(image: detailBackImageView.image, andParams: nil) ?? ""]
        shareController.completionHandler = { VKShareDialogController, result in
            self.dismiss(animated: true, completion: nil)
        }
        present(shareController, animated: true, completion: nil)
    }
    
    private func setGenresCollection() {
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
    }
    
    private func setPersonCollection() {
        personsCollectionView.delegate = self
        personsCollectionView.dataSource = self
    }

    private func setShareButton(){
        if VKSdk.isLoggedIn() {
            shareButton.isHidden = false
        } else {
            shareButton.isHidden = true
        }
    }
    
    private func setDetails() {
        detailNameLabel.text = realmMovie?.realmName
        detailYearLabel?.text = String(realmMovie?.realmYear ?? 0)
        detailDescriptionLabel.text = realmMovie?.realmDescription
        detailRatingLabel.text = String(realmMovie?.realmRatingKp ?? 0)
        if let image = realmMovie?.realmPosterUrl {
        detailBackImageView.setImageFromUrl(imageUrl: image)
        }
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

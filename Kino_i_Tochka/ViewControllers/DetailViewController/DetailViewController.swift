//
//  DetailViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 02.07.2022.
//

import UIKit
import WebKit
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailBackImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailYearLabel: UILabel!
    @IBOutlet weak var detailLenghtLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var personsCollectionView: UICollectionView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var detailRatingStarStack: UIStackView!
    @IBOutlet weak var detailVideoWV: WKWebView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var movieData: DetailMovie?
    var movie: Doc?
    private let localRealm = try! Realm()
    private var buttonSwitched : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        setDetails()
        setGenresCollection()
        setPersonCollection()
        isFavorite()
        scrollView.delegate = self
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        buttonSwitched = !buttonSwitched
        if buttonSwitched {
            setAndSaveRealmModel()
            likeButton.tintColor = .red
        } else {
            if let movie = movie {
                let reamlResult = localRealm.objects(RealmMovie.self).where { $0.realmId == movie.id }
                if let realmMovie = reamlResult.first {
                    RealmManager.shared.deleteRealmModel(model: realmMovie)
                }
            }
            likeButton.tintColor = .white
        }
    }
    
    private func setGenresCollection() {
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
    }
    
    private func setPersonCollection() {
        personsCollectionView.delegate = self
        personsCollectionView.dataSource = self
    }
    
    private func setFilmParameters() -> [String: String] {
        let parameters = [
            "field": "id",
            "search": String(movie!.id),
            "token": Constants.token
        ]
        return parameters
    }
    
    private func getDetails() {
        Network.network.fetchDetailMovie(parameters: setFilmParameters(), completion: { [unowned self] (fechedDetailMovie: DetailMovie) in
            movieData = fechedDetailMovie
            genresCollectionView.reloadData()
            personsCollectionView.reloadData()
            if let video = movieData?.videos.trailers.first?.url {
            playVideo(videoUrl: (video))
            }
        })
    }
    
    private func setDetails() {
        detailNameLabel.text = movie?.name
        detailYearLabel?.text = String(movie?.year ?? 0)
        detailDescriptionLabel.text = movie?.description
        detailRatingLabel.text = String(movie?.rating.kp ?? 0)
        if let imageUrl = movie?.poster.url {
        detailBackImageView.setImageFromUrl(imageUrl: imageUrl)
        }
        let (hour, min) = (movie?.movieLength ?? 0).convertMinutes()
        detailLenghtLabel.text = "\(hour) ч \(min) мин"
        let checkedStars = Int (((movie?.rating.kp ?? 0) - 1) / 2)
        for i in 0...checkedStars {
            if let image = detailRatingStarStack.subviews[i] as? UIImageView {
                image.image = UIImage(systemName: "star.fill")
            }
        }
    }
    
    private func playVideo(videoUrl: String) {
        guard let videoURL = URL(string: videoUrl) else { return }
        detailVideoWV.configuration.mediaTypesRequiringUserActionForPlayback = .all
        detailVideoWV.load(URLRequest(url: videoURL))
    }
    
    private func setAndSaveRealmModel() {
        let realmMovie = RealmMovie()
        realmMovie.realmName = movie?.name ?? "Unknown"
        realmMovie.realmDescription = movie?.description ?? "Unknown"
        realmMovie.realmId = movie?.id ?? 00
        realmMovie.realmMovieLenght = movie?.movieLength ?? 00
        realmMovie.realmPosterUrl = movie?.poster.url ?? "Unknown"
        realmMovie.realmYear = movie?.year ?? 00
        realmMovie.realmRatingKp = movie?.rating.kp ?? 00
        
        for i in 0...(movieData?.genres.count ?? 1) - 1 {
            realmMovie.genres.append(movieData?.genres[i].name ?? "no genre")
        }
        
        for i in 0...(movieData?.persons.count ?? 1) - 1 {
            realmMovie.realmPersonName.append(movieData?.persons[i].name ?? "Unknown")
            realmMovie.realmPersonPhoto.append(movieData?.persons[i].photo ?? "Unknown")
            realmMovie.realmPersonEnProfession.append(movieData?.persons[i].enProfession ?? "Unknown")
            realmMovie.realmPersonDescription.append(movieData?.persons[i].description ?? "Unknown")
        }
        
        RealmManager.shared.saveRealmModel(model: realmMovie)
    }

    private func isFavorite() {
        if let movie = movie {
            let reamlResult = localRealm.objects(RealmMovie.self).where { $0.realmId == movie.id }
            if reamlResult.first?.realmId == movie.id {
                likeButton.tintColor = .red
                buttonSwitched = true
            }
        }
    }
}

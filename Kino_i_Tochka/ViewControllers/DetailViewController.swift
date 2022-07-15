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
    
    var movieData: DetailMovie?
    var movie = [Doc]()
    private let localRealm = try! Realm()
    private var realmMovie = RealmMovie()
    private var realmMovieArray: Results<RealmMovie>!
    private var buttonSwitched : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        setDetails()
        setGenresCollection()
        setPersonCollection()
        setGradientOnImage()
        
        realmMovieArray = localRealm.objects(RealmMovie.self)
        isFavorite()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        buttonSwitched = !buttonSwitched
        
        if buttonSwitched {
            setAndSaveRealmModel()
            likeButton.tintColor = .red
        } else {
            for i in realmMovieArray {
                if i.realmId == movie.first?.id {
                    RealmManager.shared.deleteRealmModel(model: i)
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
            "search": String(movie.first!.id),
            "token": Constants.token
        ]
        return parameters
    }
    
    private func getDetails() {
        Network.network.fetchDetailMovie(url: Constants.detailUrl, parameters: setFilmParameters(), completion: { [unowned self] (fechedDetailMovie: DetailMovie) in
            movieData = fechedDetailMovie
            genresCollectionView.reloadData()
            personsCollectionView.reloadData()
            playVideo(videoUrl: (movieData?.videos.trailers.first!.url)!)
        })
    }
    
    private func setDetails() {
        detailNameLabel.text = movie.first?.name
        detailYearLabel?.text = String(movie.first?.year ?? 0)
        detailDescriptionLabel.text = movie.first?.description
        detailRatingLabel.text = String(movie.first?.rating.kp ?? 0)
        detailBackImageView.setImageFromUrl(imageUrl: (movie.first?.poster.url)!)
        let (hour, min) = (movie.first?.movieLength ?? 0).convertMinutes()
        detailLenghtLabel.text = "\(hour) ч \(min) мин"
        let checkedStars = Int (((movie.first?.rating.kp ?? 0) - 1) / 2)
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

    private func setGradientOnImage() {
        let gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            let viewColor: UIColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
            gradient.type = .axial
            gradient.colors = [
                UIColor.clear.cgColor,
                viewColor.withAlphaComponent(1).cgColor,
                viewColor.cgColor
            ]
            gradient.locations = [0.65, 0.9, 1]
            return gradient
        }()
        
        gradient.frame = detailBackImageView.bounds
        detailBackImageView.layer.addSublayer(gradient)
    }
    
    private func setAndSaveRealmModel() {
        realmMovie.realmName = movie.first?.name ?? "Unknown"
        realmMovie.realmDescription = movie.first?.description ?? "Unknown"
        realmMovie.realmId = movie.first?.id ?? 00
        realmMovie.realmMovieLenght = movie.first?.movieLength ?? 00
        realmMovie.realmPosterUrl = movie.first?.poster.url ?? "Unknown"
        realmMovie.realmYear = movie.first?.year ?? 00
        realmMovie.realmRatingKp = movie.first?.rating.kp ?? 00
        
        RealmManager.shared.saveRealmModel(model: realmMovie)
    }

    private func isFavorite() {
        for i in realmMovieArray {
            if i.realmId == movie.first?.id {
                likeButton.tintColor = .red
                buttonSwitched = true
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == personsCollectionView {
            return movieData?.persons.count ?? 0
        }
        return movieData?.genres.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == personsCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as? PersonCollectionViewCell {
                cell.cellConfugure(detail: (movieData?.persons[indexPath.row])!)
                return cell
            }
            return UICollectionViewCell()
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genresCell", for: indexPath) as? GenresCollectionViewCell {
            cell.genreLabel.text = movieData?.genres[indexPath.item].name
            return cell
        }
        return UICollectionViewCell()
    }
}


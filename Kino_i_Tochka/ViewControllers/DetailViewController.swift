//
//  DetailViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 02.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movieData: DetailMovie?
    var movie = [Doc]()
    
    @IBOutlet weak var detailBackImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailYearLabel: UILabel!
    @IBOutlet weak var detailLenghtLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var personsCollectionView: UICollectionView!
    @IBOutlet weak var likeButton: UIButton!
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let viewColor: UIColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        
        gradient.type = .axial
        gradient.colors = [
            UIColor.clear.cgColor,
            viewColor.withAlphaComponent(1).cgColor,
            viewColor.cgColor
        ]
        gradient.locations = [0.65, 0.85, 1]
        return gradient
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        setDetails()
        setGenresCollection()
        setPersonCollection()
        setGradientOnImage()
        
        gradient.frame = detailBackImageView.bounds
            detailBackImageView.layer.addSublayer(gradient)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        print("Add to favorite")
    }
    
    private func setGenresCollection() {
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
    }
    
    private func setPersonCollection() {
        personsCollectionView.delegate = self
        personsCollectionView.dataSource = self
    }
    
    private func getDetails() {
        Network.network.fetchDetailMovie(url: "https://api.kinopoisk.dev/movie?field=id&search=\(movie.first!.id)&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B", completion: { (fechedDetailMovie: DetailMovie) in
            self.movieData = fechedDetailMovie
            self.genresCollectionView.reloadData()
            self.personsCollectionView.reloadData()
        })
    }
    
    private func setDetails() {
        detailNameLabel.text = movie.first?.name
        detailYearLabel?.text = String(movie.first?.year ?? 0)
        detailDescriptionLabel.text = movie.first?.description
        detailRatingLabel.text = String(movie.first?.rating.kp ?? 0)
        detailBackImageView.setImageFromUrl(imageUrl: (movie.first?.poster.url)!)
        let (hour, min) = { (mins: Int) -> (Int, Int) in
            return (mins / 60, mins % 60)}(movie.first?.movieLength ?? 0)
        detailLenghtLabel.text = "\(hour) ч \(min) мин"
    }
    
    private func setGradientOnImage() {
//        self.detailBackImageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//
//        let width = self.detailBackImageView.bounds.width
//        let height = self.detailBackImageView.bounds.height
//        let sHeight:CGFloat = height * 0.5
//        let shadow = UIColor.black.withAlphaComponent(1).cgColor
//
//        // Add gradient bar for image on top
//        let topImageGradient = CAGradientLayer()
//        topImageGradient.frame = CGRect(x: 0, y: 0, width: width, height: sHeight)
//        topImageGradient.colors = [shadow, UIColor.clear.cgColor]
//        detailBackImageView.layer.insertSublayer(topImageGradient, at: 0)
//
//        let bottomImageGradient = CAGradientLayer()
//        bottomImageGradient.frame = CGRect(x: 0, y: 1, width: width, height: sHeight)
//        bottomImageGradient.colors = [UIColor.clear.cgColor, shadow]
//        detailBackImageView.layer.insertSublayer(bottomImageGradient, at: 0)
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


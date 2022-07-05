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
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        setDetails()
        setGenresCollection()
        setPersonCollection()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        print("Add to favorite")
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
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
        detailLenghtLabel.text = String(movie.first?.movieLength ?? 0)
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

// MARK: - UICollectionViewDelegateFlowLayout

//extension DetailViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == genresCollectionView {
//           return CGSize(width: 40,
//               height: collectionView.frame.height)
//        }
//        return CGSize(width: 120, height: 150)
//    }
//}

//
//  DetailViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 02.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movieData: [DetailMovie] = []
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailYearLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.network.fetchDetailMovie(completion: { (fechedDetailMovie: DetailMovie) in
            self.movieData.append(fechedDetailMovie)
            self.setDetails()
//            print("Description\(self.movieData.first?.description)")
        })
//        setDetails()
        print(movieData)
    }
    
    private func setDetails() {
        detailNameLabel.text = movieData.first?.name
        detailYearLabel?.text = "\(movieData.first?.year)"
        detailDescriptionLabel.text = movieData.first?.description
        detailRatingLabel.text = "\(movieData.first?.rating)"
    }
}

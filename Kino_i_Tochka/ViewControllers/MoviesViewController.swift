//
//  ViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var moviesData: [Doc] = []
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()

        Network.network.fetchMovieList(completion: { (fechedMovieList: [Doc]) in
            self.moviesData = fechedMovieList
            self.moviesTableView.reloadData()
        })
    }
    
    private func setTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell {
            
            cell.cellConfugure(movie: moviesData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}


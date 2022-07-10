//
//  ViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var moviesData: [Doc] = []
    var pages: Movies?
    var page = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
        setNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.moviesTableView.reloadData()
    }
    
    private func setTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
    
    private func setNetwork() {
        Network.network.fetchMovieList(url: "https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2020&field=typeNumber&search=1&sortField=votes.imdb&sortType=-1&limit=20&page=2&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B", completion: { (fechedMovieList: [Doc]) in
            self.moviesData = fechedMovieList
            self.moviesTableView.reloadData()
        })
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = moviesData.count - 1
        if indexPath.row == lastIndex {
            if page <= pages?.pages ?? 1 {
                page += 1
                Network.network.fetchMovieList(url: "https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2020&field=typeNumber&search=1&sortField=votes.imdb&sortType=-1&limit=20&page=\(page)&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B", completion: { (fechedMovieList: [Doc]) in
                    self.moviesData.append(contentsOf: fechedMovieList)
                    self.moviesTableView.reloadData()
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailViewController {
            if let cell = sender as? MovieTableViewCell, let index = moviesTableView.indexPath(for: cell)?.row{
                destinationViewController.movie.append(moviesData[index])
            }
        }
    }
}


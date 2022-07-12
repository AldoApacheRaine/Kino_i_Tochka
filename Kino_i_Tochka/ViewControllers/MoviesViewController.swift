//
//  ViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    
    var moviesData: [Doc] = []
    var pages: Int?
    var currentPage = 1
    var isDefaultChoice = true
    
    let bestFilmsUrl = "https://api.kinopoisk.dev/movie?field=typeNumber&search=1&sortField=votes.kp&sortType=-1&limit=20"
    let newFilmsUrl = "https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2022&field=typeNumber&search=1&sortField=year&sortType=-1&sortField=votes.kp&sortType=-1&limit=20"
    let token = "XSVFQ1H-BFZM73K-GNVXEQS-XDP320B"

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
        setSortButton()
        setNetwork(url: bestFilmsUrl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.moviesTableView.reloadData()
    }
    
    private func setTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
    
    private func setFilmsParameters() -> [String: String] {
        let parameters = [
            "page": "\(currentPage)",
            "token": token
        ]
        return parameters
    }
    
    private func setSortButton() {
        let allFilms = { [unowned self](action: UIAction) in
            moviesData = []
            currentPage = 1
            isDefaultChoice = true
            setNetwork(url: bestFilmsUrl)
            moviesTableView.reloadData()
        }
        let lastestFilms = { [unowned self](action: UIAction) in
            moviesData = []
            currentPage = 1
            isDefaultChoice = false
            setNetwork(url: newFilmsUrl)
            moviesTableView.reloadData()
        }
        sortButton.menu = UIMenu(children: [
            UIAction(title: "Выбор редакции", state: .on, handler: allFilms),
            UIAction(title: "Лучшие новые фильмы", handler: lastestFilms),
        ])
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.changesSelectionAsPrimaryAction = true
    }
    
    private func setPagginBestFilms() {
        if currentPage <= pages ?? 1 {
            currentPage += 1
            setNetwork(url: bestFilmsUrl)
        }
    }
    
    private func setPagginNewFilms() {
        if currentPage <= pages ?? 1 {
            currentPage += 1
            setNetwork(url: newFilmsUrl)
        }
    }
    
    private func setNetwork(url: String) {
        
        Network.network.fetchMovieList(url: url, parameters: setFilmsParameters(), completion: { [unowned self] (fechedMovieList: Movies) in
            moviesData.append(contentsOf: fechedMovieList.docs)
            pages = fechedMovieList.pages
            moviesTableView.reloadData()
        })
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
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
            isDefaultChoice ? setPagginBestFilms() : setPagginNewFilms()
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


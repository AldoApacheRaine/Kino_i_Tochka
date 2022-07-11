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
    var page = 1
    
    var someURL = ""
//    https://api.kinopoisk.dev/movie?field=typeNumber&search=1&sortField=votes.kp&sortType=-1&limit=20&page=1&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B
//    все фильмы с по убыванию голосов кп.
    
//    https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2022&field=typeNumber&search=1&sortField=year&sortType=-1&sortField=votes.kp&sortType=-1&limit=20&page=1&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B
//    новые фильмы по убыванию кп и году выпуска
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
//        setSortButton()
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
    
//    private func setSortButton() {
//        let allFilms = { [unowned self](action: UIAction) in someURL = "https://api.kinopoisk.dev/movie?field=typeNumber&search=1&sortField=votes.kp&sortType=-1&limit=20&page=\(page)&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B"
//            moviesData = []
//            page = 1
//            setNetwork(sortURL: someURL, page: page)
//            moviesTableView.reloadData()
//        }
//        let lastestFilms = { [unowned self](action: UIAction) in someURL = mainURL + latestFilmSort + String(page) + token
//            moviesData = []
//            page = 1
//            setNetwork(sortURL: someURL, page: page)
//            moviesTableView.reloadData()
//        }
//        sortButton.menu = UIMenu(children: [
//            UIAction(title: "Option 1", state: .on, handler: allFilms),
//            UIAction(title: "Option 2", handler: lastestFilms),
//        ])
//        sortButton.showsMenuAsPrimaryAction = true
//        sortButton.changesSelectionAsPrimaryAction = true
//    }
    
    private func setNetwork() {
        Network.network.fetchMovieList(url: "https://api.kinopoisk.dev/movie?field=typeNumber&search=1&sortField=votes.kp&sortType=-1&limit=20&page=\(page)&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B", completion: { [unowned self] (fechedMovieList: Movies) in
            moviesData.append(contentsOf: fechedMovieList.docs)
            pages = fechedMovieList.pages
            moviesTableView.reloadData()
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
            if page <= pages ?? 1 {
            page += 1
                setNetwork()
                print(page)
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


//
//  ViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit
import RealmSwift

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var noInternetImageView: UIImageView!
    
    var moviesData: [Doc] = []
    var movie: DetailMovie?
    var pages: Int?
    var currentPage = 1
    var isDefaultChoice = true
    private let localRealm = try! Realm()
    
    lazy var moviesRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        setTableView()
        setNavigationBar()
        setSortButton()
        getBestFilms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isInternet()
        self.moviesTableView.reloadData()
    }
    
    private func isInternet() {
        if Network.network.isConnectedToInternet() {
            moviesTableView.isHidden = false
            noInternetImageView.isHidden = true
        } else {
            moviesTableView.isHidden = true
            noInternetImageView.isHidden = false
        }
    }
    
    func getBestFilms() {
        Network.network.getBestMovies(page: currentPage) { [unowned self] (films: Movies) in
            moviesData.append(contentsOf: films.docs)
            pages = films.pages
            moviesTableView.reloadData()
            removeSpinner()
        }
    }
    
    func getNewFilms() {
        Network.network.getNewMovies(page: currentPage) { [unowned self] (films: Movies) in
            moviesData.append(contentsOf: films.docs)
            pages = films.pages
            moviesTableView.reloadData()
            removeSpinner()
        }
    }
    
    private func setTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.refreshControl = moviesRefreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        if isDefaultChoice {
            getBestFilms()
        } else {
            getNewFilms()
        }
        sender.endRefreshing()
    }
    
    private func setSortButton() {
        let allFilms = { [unowned self] (action: UIAction) in
            showSpinner()
            moviesData = []
            currentPage = 1
            isDefaultChoice = true
            isInternet()
            getBestFilms()
        }
        let lastestFilms = { [unowned self](action: UIAction) in
            showSpinner()
            moviesData = []
            currentPage = 1
            isDefaultChoice = false
            isInternet()
            getNewFilms()
        }
        sortButton.menu = UIMenu(children: [
            UIAction(title: "Выбор редакции", state: .on, handler: allFilms),
            UIAction(title: "Лучшие новые фильмы", handler: lastestFilms),
        ])
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.changesSelectionAsPrimaryAction = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailViewController {
            if let cell = sender as? MovieTableViewCell, let index = moviesTableView.indexPath(for: cell)?.row {
                destinationViewController.movie = moviesData[index]
            }
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}

// MARK: - Delegates

extension MoviesViewController: DelRealmDelegate, SaveRealmDelegate {
    func delModel(movieData: Doc) {
        let reamlResult = localRealm.objects(RealmMovie.self).where { $0.realmId == movieData.id }
        if let realmMovie = reamlResult.first {
            RealmManager.shared.deleteRealmModel(model: realmMovie)
        }
    }
    
    func saveModel(movieData: Doc) {
        let realmMovie = RealmMovie()
        realmMovie.realmName = movieData.name ?? "Unknown"
        realmMovie.realmDescription = movieData.description ?? "Unknown"
        realmMovie.realmId = movieData.id
        realmMovie.realmMovieLenght = movieData.movieLength ?? 00
        realmMovie.realmPosterUrl = movieData.poster.url
        realmMovie.realmYear = movieData.year
        realmMovie.realmRatingKp = movieData.rating.kp
        Network.network.getMovieDetails(id: movieData.id) { [unowned self] (detail: DetailMovie) in
            for i in 0...(detail.genres.count) - 1 {
                try! localRealm.write {
                    realmMovie.genres.append(detail.genres[i].name)
                }
            }
            for i in 0...(detail.persons.count) - 1 {
                try! localRealm.write {
                    realmMovie.realmPersonName.append(detail.persons[i].name)
                    realmMovie.realmPersonPhoto.append(detail.persons[i].photo)
                    realmMovie.realmPersonEnProfession.append(detail.persons[i].enProfession)
                    realmMovie.realmPersonDescription.append(detail.persons[i].description)
                }
            }
        }
        RealmManager.shared.saveRealmModel(model: realmMovie)
    }
}

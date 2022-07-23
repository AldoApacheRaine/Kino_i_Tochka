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
    @IBOutlet weak var noInternetImageView: UIImageView!
    
    var moviesData: [Doc] = []
    var pages: Int?
    var currentPage = 1
    var isDefaultChoice = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
        setSortButton()
        setNetwork(url: Constants.bestFilmsUrl)
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
    
    private func setTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
    
    private func setFilmsParameters() -> [String: String] {
        let parameters = [
            "page": "\(currentPage)",
            "token": Constants.token
        ]
        return parameters
    }
    
    private func setSortButton() {
        let allFilms = { [unowned self](action: UIAction) in
            moviesData = []
            currentPage = 1
            isDefaultChoice = true
            isInternet()
            setNetwork(url: Constants.bestFilmsUrl)
            moviesTableView.reloadData()
        }
        let lastestFilms = { [unowned self](action: UIAction) in
            moviesData = []
            currentPage = 1
            isDefaultChoice = false
            isInternet()
            setNetwork(url: Constants.newFilmsUrl)
            moviesTableView.reloadData()
        }
        sortButton.menu = UIMenu(children: [
            UIAction(title: "Выбор редакции", state: .on, handler: allFilms),
            UIAction(title: "Лучшие новые фильмы", handler: lastestFilms),
        ])
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.changesSelectionAsPrimaryAction = true
    }
    
    func setPagginBestFilms() {
        if currentPage <= pages ?? 1 {
            currentPage += 1
            setNetwork(url: Constants.bestFilmsUrl)
        }
    }
    
    func setPagginNewFilms() {
        if currentPage <= pages ?? 1 {
            currentPage += 1
            setNetwork(url: Constants.newFilmsUrl)
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

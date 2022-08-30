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
    
    var moviesViewModel: MoviesViewModelType?
    var isDefaultChoice = true
    let moviesRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        moviesViewModel = MoviesViewModel()
        setTableView()
        setNavigationBar()
        setSortButton()
        moviesViewModel?.getBestMovies(complition: { [unowned self] in
            moviesTableView.reloadData()
            removeSpinner()
            
        })
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
        moviesTableView.refreshControl = moviesRefreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        if isDefaultChoice {
            moviesViewModel?.getBestMovies {}
        } else {
            moviesViewModel?.getNewMovies {}
        }
        moviesTableView.reloadData()
        sender.endRefreshing()
    }
    
    private func setSortButton() {
        let allFilms = { [unowned self] (action: UIAction) in
            showSpinner()
            moviesViewModel?.setDefaultMovies()
            isDefaultChoice = true
            isInternet()
            moviesViewModel?.getBestMovies(complition: {[unowned self] in
                moviesTableView.reloadData()
                removeSpinner()
            })
        }
        let lastestFilms = { [unowned self](action: UIAction) in
            showSpinner()
            moviesViewModel?.setDefaultMovies()
            isDefaultChoice = false
            isInternet()
            moviesViewModel?.getNewMovies(complition: { [unowned self] in
                moviesTableView.reloadData()
                removeSpinner()
            })
        }
        sortButton.menu = UIMenu(children: [
            UIAction(title: "Выбор редакции", state: .on, handler: allFilms),
            UIAction(title: "Лучшие новые фильмы", handler: lastestFilms),
        ])
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.changesSelectionAsPrimaryAction = true
    }

    func setPagginBestFilms() {
        moviesViewModel?.getBestMovies(complition: {[unowned self] in
            moviesTableView.reloadData()
        })
    }

    func setPagginNewFilms() {
        moviesViewModel?.getNewMovies(complition: { [unowned self] in
            moviesTableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailViewController {
            if let cell = sender as? MovieTableViewCell, let index = moviesTableView.indexPath(for: cell)?.row, let viewModel = moviesViewModel {
                destinationViewController.movie = viewModel.getMovie(index: index)
            }
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}

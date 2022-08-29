//
//  MoviesViewModel.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 14.08.2022.
//

import Foundation

class MoviesViewModel: MoviesViewModelType {
 
    var movies: [Doc] = []
    var pages: Int?
    var currentPage = 1
    var isDefaultChoice = true
    
    
    func setBestFilmsParameters() -> [String: String] {
        let parameters = [
            "field": "typeNumber",
            "search": "1",
            "sortField": "votes.kp",
            "sortType": "-1",
            "limit": "20",
            "page": "\(currentPage)",
            "token": Constants.token
        ]
        return parameters
    }
    
    func setNewFilmsParameters() -> [String: String] {
        let parameters = [
            "limit": "20",
            "page": "\(currentPage)",
            "token": Constants.token
        ]
        return parameters
    }
    
    func getBestMovies(complition: @escaping() -> ()) {
        Network.network.fetchBestMovieList(parameters: setBestFilmsParameters(), completion: { [unowned self] (fechedMovieList: Movies) in
            movies.append(contentsOf: fechedMovieList.docs)
            pages = fechedMovieList.pages
            complition()
        })
    }
    
    func getNewMovies(complition: @escaping() -> ()) {
        Network.network.fetchNewMovieList(parameters: setNewFilmsParameters(), completion: { [unowned self] (fechedMovieList: Movies) in
            movies.append(contentsOf: fechedMovieList.docs)
            pages = fechedMovieList.pages
            complition()
        })
    }
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MoviesCellViewModelType? {
        let movie = movies[indexPath.row]
        return MoviesCellViewModel(movie: movie)
    }
    
    func getMovie(index: Int) -> Doc {
        return self.movies[index]
    }
    
    func pagination() {
        if currentPage <= pages ?? 1 {
            currentPage += 1                    
        }
    }
    
    func setDefaultMovies() {
            movies = []
            currentPage = 1
    }
    
    
    
}

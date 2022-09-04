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
    
    func getBestMovies(complition: @escaping() -> ()) {
        Network.network.getBestMovies(page: currentPage) { (movieList: Movies) in
            self.movies.append(contentsOf: movieList.docs)
            self.pages = movieList.pages
            complition()
        }
    }
    
    func getNewMovies(complition: @escaping() -> ()) {
        Network.network.getNewMovies(page: currentPage) { (movieList: Movies) in
            self.movies.append(contentsOf: movieList.docs)
            self.pages = movieList.pages
            complition()
        }
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

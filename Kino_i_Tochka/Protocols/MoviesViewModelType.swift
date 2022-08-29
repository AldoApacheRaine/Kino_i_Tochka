//
//  MoviesViewModelType.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 15.08.2022.
//

import Foundation

protocol MoviesViewModelType {
    
    func getBestMovies(complition: @escaping() -> ())
    
    func getNewMovies(complition: @escaping() -> ())
    
    func numberOfRows() -> Int
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MoviesCellViewModelType?
    
    func getMovie(index: Int) -> Doc
    
    func pagination()
    
    func setDefaultMovies()
    
}

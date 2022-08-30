//
//  MoviesCellViewModel.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 15.08.2022.
//

import Foundation

class MoviesCellViewModel: MoviesCellViewModelType {
   
    private var movie: Doc
    
    var poster: String {
        return movie.poster.url
    }
    
    var rating: Double {
        return movie.rating.kp
    }
    
    var id: Int {
        return movie.id
    }
    
    var movieLength: Int? {
        return movie.movieLength
    }
    
    var name: String? {
        return movie.name
    }
    
    var description: String? {
        return movie.description
    }
    
    var year: Int {
        return movie.year
    }
    
    init(movie: Doc) {
        self.movie = movie
    }
}

//
//  DetailMovieModel.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 02.07.2022.
//

import Foundation

struct DetailMovie: Codable {
    let poster: Poster
    let rating: Rating
    let videos: Videos?
    let genres: [Genres]
    let description: String
    let movieLength: Int
    let name: String
    let year: Int
}

struct Videos: Codable {
    let trailers: [Trailer]
}

struct Trailer: Codable {
    let url: String
}

struct Genres: Codable {
    let name: String
}


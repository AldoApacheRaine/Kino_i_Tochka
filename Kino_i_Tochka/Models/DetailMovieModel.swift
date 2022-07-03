//
//  DetailMovieModel.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 02.07.2022.
//

import Foundation

struct DetailMovie: Codable {
    let videos: Videos
    let genres: [Genres]
    let persons: [Persons]
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

struct Persons: Codable {
    let name: String
    let description: String?
    let enProfession: String
    let photo: String
}


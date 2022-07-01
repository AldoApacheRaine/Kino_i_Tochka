//
//  MoviesModel.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import Foundation

struct Movies: Codable {
    let docs: [Doc]
}

struct Doc: Codable {
    let poster: Poster
    let rating: Rating
    let id: Int
    let movieLength: Int?
    let name: String
    let year: Int
}

struct Poster: Codable {
    let url: String
}

struct Rating: Codable {
    let kp: Double
}



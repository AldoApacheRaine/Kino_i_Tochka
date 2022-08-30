//
//  MoviesCellViewModelType.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 15.08.2022.
//

import Foundation

protocol MoviesCellViewModelType: AnyObject {
    var poster: String { get }
    var rating: Double { get }
    var id: Int { get }
    var movieLength: Int? { get }
    var name: String? { get }
    var description: String? { get }
    var year: Int { get }
}

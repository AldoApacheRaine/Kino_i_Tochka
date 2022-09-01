//
//  Constants.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 15.07.2022.
//

import Foundation

struct Constants {
//    static let bestFilmsUrl = "https://api.kinopoisk.dev/movie?field=typeNumber&search=1&sortField=votes.kp&sortType=-1&limit=20"
//    static let newFilmsUrl = "https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2022&field=typeNumber&search=1&sortField=year&sortType=-1&sortField=votes.kp&sortType=-1&limit=20"
//    static let detailUrl = "https://api.kinopoisk.dev/movie?field=id"

    static let mainUrl: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.kinopoisk.dev"
        components.path = "/movie"
        return components
    }()
    
    static func newFilmsUrl() -> URL {
        var newUrl = URLComponents()
        newUrl.scheme = "https"
        newUrl.host = "api.kinopoisk.dev"
        newUrl.path = "/movie"
        let queryItems = [URLQueryItem(name: "field", value: "rating.kp"), URLQueryItem(name: "search", value: "5-10"), URLQueryItem(name: "field", value: "year"), URLQueryItem(name: "search", value: "2015-2022"), URLQueryItem(name: "field", value: "typeNumber"), URLQueryItem(name: "search", value: "1"), URLQueryItem(name: "sortField", value: "year"), URLQueryItem(name: "sortType", value: "-1"), URLQueryItem(name: "sortField", value: "votes.kp"), URLQueryItem(name: "sortType", value: "-1")]
        newUrl.queryItems = queryItems
        let result = newUrl.url!
        return result
    }
    
    static let token = Bundle.main.infoDictionary?["API_KEY"] as! String
}

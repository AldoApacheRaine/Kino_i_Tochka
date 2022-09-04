//
//  Network.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import Foundation
import Alamofire
import Moya


final class Network {
    
    static let network = Network()
    var moviesProvider = MoyaProvider<MoviesService>()

    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func getBestMovies(page: Int, complition: @escaping (Movies) -> Void) {
        moviesProvider.request( .bestMovies(page: page)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let json = try JSONDecoder().decode(Movies.self, from: response.data)
                    complition(json)
                } catch let error {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getNewMovies(page: Int, complition: @escaping (Movies) -> Void) {
        moviesProvider.request( .newMovies(page: page)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let json = try JSONDecoder().decode(Movies.self, from: response.data)
                    complition(json)
                } catch let error {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getMovieDetails(id: Int, complition: @escaping (DetailMovie) -> Void) {
        moviesProvider.request( .detailMovie(id: id)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let json = try JSONDecoder().decode(DetailMovie.self, from: response.data)
                    complition(json)
                } catch let error {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
    


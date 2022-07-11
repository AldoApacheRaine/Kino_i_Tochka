//
//  Network.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import Foundation
import Alamofire

final class Network {
    
    static let network = Network()
    
    func fetchMovieList(url: String, completion: @escaping (Movies) -> Void) {
        AF.request(url).responseDecodable(of: Movies.self) { response in
            if let movieList = try? response.result.get(){
                completion(movieList)
            }
        }
    }
    
    func fetchDetailMovie(url: String, completion: @escaping (DetailMovie) -> Void) {
        AF.request(url).responseDecodable(of: DetailMovie.self) { response in
            if let detailList = try? response.result.get(){
                completion(detailList)
            }
        }
    }
}
    


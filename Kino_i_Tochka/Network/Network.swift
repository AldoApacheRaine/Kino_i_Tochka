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
    
    func fetchMovieList(completion: @escaping ([Doc]) -> Void) {
        AF.request(Links.allLink).responseDecodable(of: Movies.self) { response in
            if let movieList = try? response.result.get(){
                completion(movieList.docs)
            }
        }
    }
    
    func fetchDetailMovie(completion: @escaping (DetailMovie) -> Void) {
        AF.request(Links.galaxyMovieLink).responseDecodable(of: DetailMovie.self) { response in
            if let detailList = try? response.result.get(){
                completion(detailList)
            }
        }
    }
}
    


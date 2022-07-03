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
        AF.request("https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2020&field=typeNumber&search=1&sortField=votes.imdb&sortType=-1&limit=20&page=2&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B").responseDecodable(of: Movies.self) { response in
            if let movieList = try? response.result.get(){
                completion(movieList.docs)
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
    


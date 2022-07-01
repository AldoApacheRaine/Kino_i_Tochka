//
//  Network.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

//import Foundation
//import Alamofire
//
//class Network {
//
//    var moviesData: [Movies] = []
//
//    func retriveData(_ tableView: UITableView) {
//        AF.request("\(Links.mainLink) + \(Links.sortVotes) + \(Links.limitOnPage) + \(Links.page) + \(Links.token)").responseDecodable(of: [Movies].self) { response in
//            if let movieslist = try? response.result.get(){
//                self.moviesData.append(contentsOf: movieslist)
//                tableView.reloadData()
//                
//            }
//        }
//    }
//}

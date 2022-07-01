//
//  ViewController.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class MoviesViewController: UIViewController {

//    let network = Network()
    var moviesData: [Movies] = []
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
//        network.retriveData(moviesTableView)
        retriveData()
        
    }
    
    private func setTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
    

    func retriveData() {
        AF.request("https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2020&field=typeNumber&search=1&sortField=votes.imdb&sortType=-1&limit=2&page=2&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B", method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json["docs"])
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    

}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell {
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}


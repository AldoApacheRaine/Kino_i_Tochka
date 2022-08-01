//
//  MoviesViewController + UITableView.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 23.07.2022.
//

import Foundation
import UIKit

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell {
            cell.cellConfugure(movie: moviesData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = moviesData.count - 1
        if indexPath.row == lastIndex {
            isDefaultChoice ? setPagginBestFilms() : setPagginNewFilms()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailViewController {
            if let cell = sender as? MovieTableViewCell, let index = moviesTableView.indexPath(for: cell)?.row{
                destinationViewController.movie.append(moviesData[index])
            }
        }
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let destinationViewController = CodeDetailViewController()
//        destinationViewController.movie = moviesData[indexPath.row]
//        navigationController?.pushViewController(destinationViewController, animated: true)
//    }
}


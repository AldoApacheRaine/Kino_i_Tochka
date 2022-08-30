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
        moviesViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell {
            guard let viewModel = moviesViewModel else { return UITableViewCell() }
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            cell.viewModel = cellViewModel
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let viewModel = moviesViewModel {
            let lastIndex = viewModel.numberOfRows() - 1
            if indexPath.row == lastIndex {
                viewModel.pagination()
                isDefaultChoice ? setPagginBestFilms() : setPagginNewFilms()
                
            }
        }
    }

    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let destinationViewController = CodeDetailViewController()
    //        destinationViewController.movie = moviesData[indexPath.row]
    //        navigationController?.pushViewController(destinationViewController, animated: true)
    //    }
}


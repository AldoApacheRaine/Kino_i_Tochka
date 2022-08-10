//
//  UIImageView + Extension.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 03.07.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFromUrl(imageUrl: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: imageUrl),placeholder: UIImage(named: "placeholderFilms"), options: [.transition(.fade(0.3))])
    }
}

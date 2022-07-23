//
//  DetailViewController + UIScrollView.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 23.07.2022.
//

import Foundation
import UIKit

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if offset.y < 0.0 {
            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, offset.y, 0)
            let scaleFactor = 1 + (-1 * offset.y / (detailBackImageView.frame.height / 2))
            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
            detailBackImageView.layer.transform = transform
        } else {
            detailBackImageView.layer.transform = CATransform3DIdentity
        }
    }
}

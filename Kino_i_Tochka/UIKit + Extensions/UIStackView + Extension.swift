//
//  UIStackView + Extension.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 27.07.2022.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, aligment: Alignment, distribution: Distribution, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.alignment = aligment
        self.distribution = distribution
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

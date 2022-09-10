//
//  UIActivityIndicator + Extension.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 22.08.2022.
//

import UIKit

fileprivate var backgroundView = UIView()
fileprivate var activityIndicator = UIActivityIndicatorView()

extension UIViewController {
    
    func showSpinner() {
        backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.7
        activityIndicator.center = backgroundView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicator)
        self.view.addSubview(backgroundView)
    }
    
    func removeSpinner() {
        backgroundView.removeFromSuperview()
        activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}

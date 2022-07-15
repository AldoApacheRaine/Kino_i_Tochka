//
//  Int + Extension.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 13.07.2022.
//

import Foundation

extension Int {
    func convertMinutes() -> (Int, Int) {
        let hour = self / 60
        let min = self % 60
        return (hour, min)
    }
}

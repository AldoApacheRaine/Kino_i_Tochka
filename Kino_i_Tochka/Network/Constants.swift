//
//  Constants.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 15.07.2022.
//

import Foundation

struct Constants {
    static let bestFilmsUrl = "https://api.kinopoisk.dev/movie?field=typeNumber&search=1&sortField=votes.kp&sortType=-1&limit=20"
    static let newFilmsUrl = "https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2022&field=typeNumber&search=1&sortField=year&sortType=-1&sortField=votes.kp&sortType=-1&limit=20"
    static let detailUrl = "https://api.kinopoisk.dev/movie?field=id"
    static let token = "XSVFQ1H-BFZM73K-GNVXEQS-XDP320B"
}

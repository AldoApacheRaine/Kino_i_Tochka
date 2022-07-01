//
//  Links.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 01.07.2022.
//

import Foundation

//https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2020&field=typeNumber&search=1&sortField=votes.imdb&sortType=-1&limit=20&page=2&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B
//&sortField=year&sortType=1
//https://api.kinopoisk.dev/movie?field=id&search=326&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B

class Links {
    static let mainLink = "https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2022&field=typeNumber&search=1"
    static let sortVotes = "&sortField=votes.imdb&sortType=-1"
    static let sortYear = "&sortField=year&sortType=-1"
    static let limitOnPage = "&limit=20"
    static let page = "&page=1"
    static let token = "&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B"
    static let detailLink = "https://api.kinopoisk.dev/movie?field=id&search="
    static let detailId = ""
    
}

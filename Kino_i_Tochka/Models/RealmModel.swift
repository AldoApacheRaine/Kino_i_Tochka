//
//  RealmModel.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 08.07.2022.
//

import Foundation
import RealmSwift

class RealmMovie: Object {
    @Persisted var realmPosterUrl: String = ""
    @Persisted var realmRatingKp: Double = 0
    @Persisted var realmId: Int = 0
    @Persisted var realmMovieLenght: Int = 0
    @Persisted var realmName: String = ""
    @Persisted var realmDescription: String = ""
    @Persisted var realmYear: Int = 0
    @Persisted var genres: List<String>
    @Persisted var realmPersonName: List<String>
    @Persisted var realmPersonDescription: List<String?>
    @Persisted var realmPersonEnProfession: List<String>
    @Persisted var realmPersonPhoto: List<String>
}


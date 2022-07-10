//
//  RealmManager.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 08.07.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveRealmModel(model: RealmMovie) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteRealmModel(model: RealmMovie) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
}

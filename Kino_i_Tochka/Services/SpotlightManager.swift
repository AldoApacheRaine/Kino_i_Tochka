//
//  SpotlightManager.swift
//  Kino_i_Tochka
//
//  Created by Максим Хмелев on 13.08.2022.
//

import Foundation
import CoreSpotlight
import MobileCoreServices
import UIKit

class SpotlightManager {
    class func setupSpotlight(with model: [RealmMovie], and domainIdentifier: String) {
        DispatchQueue.main.async {
            var searchableItems = [CSSearchableItem]()
            
            CSSearchableIndex.default().deleteSearchableItems(withDomainIdentifiers: [domainIdentifier], completionHandler: nil)
            
            model.forEach {
                let searchableItemAttributeSet = CSSearchableItemAttributeSet(contentType: .content)
                searchableItemAttributeSet.title = $0.realmName
                searchableItemAttributeSet.contentDescription = $0.realmDescription
                searchableItemAttributeSet.thumbnailData = try? Data(contentsOf: $0.realmPosterUrl.asURL())
                
                let keywords = [$0.realmName]
                searchableItemAttributeSet.keywords = keywords
                
                let id = $0.realmId
                let item = CSSearchableItem(uniqueIdentifier: "\(id)", domainIdentifier: domainIdentifier, attributeSet: searchableItemAttributeSet)
                searchableItems.append(item)
            }
            
            CSSearchableIndex.default().indexSearchableItems(searchableItems, completionHandler: { print(($0?.localizedDescription) ?? "") })
        }
    }
}




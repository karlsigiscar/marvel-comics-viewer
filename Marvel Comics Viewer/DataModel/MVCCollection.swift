//
//  MVCCollection.swift
//  Marvel Comics Viewer
//
//  Created by Developer on 06/10/2022.
//

import Foundation

struct MVCCollection: Decodable {
    var available: Int?
    var collectionURI: String?
    var items: [MVCCollectionItem]?
    var returned: Int?
}

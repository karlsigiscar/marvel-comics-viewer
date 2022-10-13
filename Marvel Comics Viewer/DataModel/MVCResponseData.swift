//
//  MVCResponseData.swift
//  Marvel Comics Viewer
//
//  Created by Developer on 06/10/2022.
//

import Foundation

struct MVCResponseData<Element>: Decodable where Element: Decodable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Element]?
}

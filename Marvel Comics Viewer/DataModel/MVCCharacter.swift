//
//  MVCCharacter.swift
//  Marvel Comics Viewer
//
//  Created by Developer on 12/10/2022.
//

import Foundation

struct MVCCharacter: Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var thumbnail: MVCImage
    var resourceURI: String?
    var comics: MVCCollection?
    var series: MVCCollection?
    var stories: MVCCollection?
    var events: MVCCollection?
    var urls: [MVCURL]?
}

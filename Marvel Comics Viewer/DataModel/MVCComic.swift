//
//  MVCComic.swift
//  Marvel Comics Viewer
//
//  Created by Developer on 05/10/2022.
//

import Foundation

/// The following fields are NOT mapped: variants, collections and collectedIssues
struct MVCComic: Decodable {
    var id: Int?
    var digitalId: Int?
    var title: String?
    var issueNumber: Int?
    var variantDescription: String?
    var description: String?
    var modified: String?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String?
    var pageCount: Int?
    var textObjects: [MVCText]?
    var resourceURI: String?
    var urls: [MVCURL]?
    var series: MVCCollectionItem?
    var dates: [MVCDate]?
    var prices: [MVCPrice]?
    var thumbnail: MVCImage?
    var images: [MVCImage]?
    var creators: MVCCollection?
    var characters: MVCCollection?
    var stories: MVCCollection?
    var events: MVCCollection?
}

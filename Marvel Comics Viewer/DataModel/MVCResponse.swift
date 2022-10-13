//
//  MVCResponse.swift
//  Marvel Comics Viewer
//
//  Created by Developer on 06/10/2022.
//

import Foundation

struct MVCResponse<Element>: Decodable where Element: Decodable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: MVCResponseData<Element>?
}

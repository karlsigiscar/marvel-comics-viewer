//
//  ConfigTests.swift
//  Marvel Comics ViewerTests
//
//  Created by Developer on 28/09/2022.
//

import XCTest
@testable import Marvel_Comics_Viewer

class ConfigTests: XCTestCase {
    private var sut: Config?
    
    override func setUpWithError() throws {
        sut = Config()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_LoadConfig_ReturnsCorrectData() throws {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.apiKeyPublic, "2ed5f893c433149f70fbcace59dc152a")
        XCTAssertEqual(sut?.apiKeyPrivate, "e216a366ff3457b31aa30dd6d0771b1c6ca5f7a5")
        XCTAssertEqual(sut?.rootURL, "https://gateway.marvel.com:443")
        XCTAssertEqual(sut?.endpoints.characterComics, "/v1/public/characters/{characterId}/comics")
    }
    
    func test_BuildURLString_ConstructCorrectString() throws {
        guard let endpoint = sut?.endpoints.characterComics else {
            XCTFail()
            return
        }
        let timestampString = String(Date().timeIntervalSince1970)
        
        if let sut = sut {
            let md5Data = MD5.getMD5(string: "\(timestampString)\(sut.apiKeyPrivate)\(sut.apiKeyPublic)")
            let hashString = md5Data.map { String(format: "%02hhx", $0) }.joined()
            let urlString = sut.buildURLString(endpoint: endpoint, match: "characterId", timeStamp: timestampString, hash: hashString, id: "1011334")
            XCTAssertEqual(urlString, "https://gateway.marvel.com:443/v1/public/characters/1011334/comics?ts=\(timestampString)&apikey=2ed5f893c433149f70fbcace59dc152a&hash=\(hashString)")
        } else {
            XCTFail()
        }
    }
}

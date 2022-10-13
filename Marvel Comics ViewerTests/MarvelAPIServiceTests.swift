//
//  MarvelAPIServiceTests.swift
//  Marvel Comics ViewerTests
//
//  Created by Developer on 28/09/2022.
//

import XCTest
@testable import Marvel_Comics_Viewer

class MarvelAPIServiceTests: XCTestCase {
    private var sut: MarvelAPIService?
    
    override func setUpWithError() throws {
        sut = MarvelAPIService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_FetchData_WithCorrectURL_GetsValidData() async throws {
        guard let config = Config() else {
            XCTFail()
            return
        }
        
        let endpoint = config.endpoints.characterComics
        let timestampString = String(Date().timeIntervalSince1970)
        let md5Data = MD5.getMD5(string: "\(timestampString)\(config.apiKeyPrivate)\(config.apiKeyPublic)")
        let hashString = md5Data.map { String(format: "%02hhx", $0) }.joined()
        let urlString = config.buildURLString(endpoint: endpoint, match: "characterId", timeStamp: timestampString, hash: hashString, id: "1011334")

        let data = try await sut?.fetchData(withURLString: urlString)
        XCTAssertNotNil(data)
    }

    func testPerformanceExample() throws {
    }
}

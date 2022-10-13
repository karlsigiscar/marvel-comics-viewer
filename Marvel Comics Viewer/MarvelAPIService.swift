//
//  MarvelAPIService.swift
//  Marvel Comics Viewer
//
//  Created by Developer on 28/09/2022.
//

import Foundation

enum FetchError: Error {
    case badURL
}

struct MarvelAPIService {
    private let decoder = JSONDecoder()
    private let config = Config()

    func fetchCharactersList() async throws -> MVCResponse<MVCCharacter>? {
        guard let endpoint = config?.endpoints.charactersList else {
            return nil
        }

        print(">>>>>>> endpoint <<<<<<<: \n\n\(endpoint)")

        guard let urlString = createURLString(endpoint: endpoint) else {
            return nil
        }

        guard let dataModel: MVCResponse<MVCCharacter> = try await fetchDataAndDecodeJSON(from: urlString) else {
            return nil
        }

        return dataModel
    }

    func fetchCharacter(match: String, id: String) async throws -> MVCResponse<MVCCharacter>? {
        guard let endpoint = config?.endpoints.character else {
            return nil
        }

        print(">>>>>>> endpoint <<<<<<<: \n\n\(endpoint)")

        guard let urlString = createURLString(endpoint: endpoint, match: match, id: id) else {
            return nil
        }

        guard let dataModel: MVCResponse<MVCCharacter> = try await fetchDataAndDecodeJSON(from: urlString) else {
            return nil
        }

        return dataModel
    }

    func fetchCharacterComics(match: String, id: String) async throws -> MVCResponse<MVCComic>? {
        guard let endpoint = config?.endpoints.characterComics else {
            return nil
        }

        print(">>>>>>> endpoint <<<<<<<: \n\n\(endpoint)")

        guard let urlString = createURLString(endpoint: endpoint, match: match, id: id) else {
            return nil
        }

        guard let dataModel: MVCResponse<MVCComic> = try await fetchDataAndDecodeJSON(from: urlString) else {
            return nil
        }
        
        return dataModel
    }
    
    private func createURLString(endpoint: String, match: String? = nil, id: String? = nil) -> String? {
        guard let config = config else {
            return nil
        }
        
        let timestampString = String(Date().timeIntervalSince1970)
        // md5(ts+privateKey+publicKey)
        let md5Data = MD5.getMD5(string: "\(timestampString)\(config.apiKeyPrivate)\(config.apiKeyPublic)")
        let hashString = md5Data.map { String(format: "%02hhx", $0) }.joined()
        let urlString = config.buildURLString(endpoint: endpoint, match: match, timeStamp: timestampString, hash: hashString, id: id)
        return urlString
    }
    
    private func fetchDataAndDecodeJSON<T>(from urlString: String) async throws -> T? where T: Decodable {
        guard let data = try await fetchData(withURLString: urlString) else {
            throw FetchError.badURL
        }

        do {
            return try decoder.decode(T.self, from: data)
        }
        catch DecodingError.typeMismatch(let type, let context) {
            print("DecodingError.typeMismatch: \(type) \(context.debugDescription)")
        }
        catch DecodingError.valueNotFound(let type, let context) {
            print("DecodingError.valueNotFound: \(type) \(context.debugDescription)")
        }
        catch DecodingError.keyNotFound(let codingKey, let context) {
            print("DecodingError.keyNotFound: \(codingKey.stringValue) \(context.debugDescription)")
        }
        catch DecodingError.dataCorrupted(let context) {
            print("DecodingError.dataCorrupted: \(context.debugDescription)")
        }
        return nil
    }
    
    func fetchData(withURLString urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        guard statusCode == 200 else {
            throw FetchError.badURL
        }
        return data
    }
}

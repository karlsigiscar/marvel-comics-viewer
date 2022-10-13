//
//  ViewModel.swift
//  Marvel Comics Viewer
//
//  Created by Developer on 28/09/2022.
//

import Foundation
import Combine

class ViewModel {
    private let service = MarvelAPIService()
    
    var characterListDataModel: MVCResponse<MVCCharacter>?
    var characterDataModel: MVCResponse<MVCCharacter>?
    var characterComicsDataModel: MVCResponse<MVCComic>?

    func fetchCharactersList() async throws {
        characterListDataModel = try await service.fetchCharactersList()
    }
    
    // Should we extract the matching property name from the config ?
    
    func fetchCharacter(id: String) async throws {
        characterDataModel = try await service.fetchCharacter(match: "characterId", id: id)
    }

    func fetchCharacterComics(id: String) async throws {
        characterComicsDataModel = try await service.fetchCharacterComics(match: "characterId", id: id)
    }
}

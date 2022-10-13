//
//  ContentView.swift
//  Marvel Comics Viewer
//
//  Created by Developer on 27/09/2022.
//

import SwiftUI

struct ContentView: View {
    private let config = Config()
    private var viewModel = ViewModel()
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                Task {
                    try await viewModel.fetchCharacter(id: "1011334")
                    print("dataModel: \(String(describing: viewModel.characterDataModel))")
//                    try await viewModel.fetchCharacterComics(id: "1011334")
//                    print("dataModel: \(String(describing: viewModel.characterComicsDataModel))")
//                    try await viewModel.fetchCharactersList()
//                    print("dataModel: \(String(describing: viewModel.characterListDataModel))")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

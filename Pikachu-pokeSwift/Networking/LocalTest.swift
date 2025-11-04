//
//  LocalTest.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import Foundation


//class LocalAPIService {
//    static let shared = LocalAPIService()
//
//    func fetchPokemonList(completion: @escaping ([PokemonListDataResults]) -> Void) {
//        guard let path = Bundle.main.path(forResource: "pokemon_mock", ofType: "json") else {
//            completion([])
//            return
//        }
//
//        let url = URL(fileURLWithPath: path)
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            let result = try decoder.decode(PokemonListData.self, from: data)
//            completion(result.data ?? [])
//        } catch {
//            print("❌ Error decoding JSON:", error)
//            completion([])
//        }
//    }
//}

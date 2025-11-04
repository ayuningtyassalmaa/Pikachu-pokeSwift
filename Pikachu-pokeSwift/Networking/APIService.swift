//
//  APIService.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import Foundation
import Alamofire

class APIService {
    static let pokeListCard = "https://api.pokemontcg.io/v2/cards/"
    
    static let shared = APIService()
    static let apiKey = "b0f5a517-757d-4a97-9adc-f324ff3a3335"
    
    func pokemonAPICards(id: String, completion: @escaping (PokemonListDataResults?) -> Void) {
        let endPoint = "\(APIService.pokeListCard)\(id)"
        print(endPoint)
        
//        let params: [String: Any] = [
//            "api_key": APIService.apiKey
//        ]
        
        AF.request(endPoint, method: .get ).validate().responseDecodable(of: PokemonListData.self) { response in
            switch response.result {
            case .success(let pokeList):
                completion(pokeList.data)
                print("✅ Success:", pokeList)
            case .failure(let dataError):
                print("ga muncul")
                print("❌ Request failed:", dataError)
                print("endpoint", endPoint)
                            }
        }
    }
}

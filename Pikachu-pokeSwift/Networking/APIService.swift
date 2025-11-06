//
//  APIService.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import Foundation
import Alamofire

class APIService {
    static let pokeListCard = "https://api.pokemontcg.io/v2/cards?page=1&pageSize=2"
    static let pokeDetailCard = "https://api.pokemontcg.io/v2/cards/"
    
    static let shared = APIService()
    static let apiKey = "b0f5a517-757d-4a97-9adc-f324ff3a3335"
    
    static let customSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 200.0
        return Session(configuration: configuration)
    }()
    
    func pokemonAPICards(completion: @escaping ([PokemonListDataResults]?) -> Void) {
        let endPoint = "\(APIService.pokeListCard)"
        print(endPoint)
        AF.request(endPoint, method: .get ).validate().responseDecodable(of: PokemonListData.self) { response in
            switch response.result {
            case .success(let pokeList):
                completion(pokeList.data ?? [])
                print("✅ Success:", pokeList)
            case .failure(let dataError):
                print("ga muncul")
                print("data error", dataError)
                print("endpoint", endPoint)
            }
        }
    }
    
    func pokemonAPIDetails(id: String, completion: @escaping (PokemonDetailDataResults?) -> Void) {
        let endPoint = "\(APIService.pokeDetailCard)\(id)"
        let query: HTTPHeaders = [
            "x-api-key": APIService.apiKey
        ]
        
        print("endpoint 2", endPoint)
        
        APIService.customSession.request(endPoint, method: .get, headers: query)
            .validate()
            .responseDecodable(of: PokemonDetailData.self) { response in
                
                switch response.result {
                          case .success(let pokeList):
                              print("sebelum", pokeList.data )
                              completion(pokeList.data)
                              print("suksesss:", pokeList)
                          case .failure(let dataError):
                              print("ga muncul dih")
                              print("data error", dataError)
                              print("endpoint", endPoint)
                          }
                
            }
        
//        AF.request(endPoint, method: .get ).validate().responseDecodable(of: PokemonDetailData.self) { response in
//            switch response.result {
//            case .success(let pokeList):
//                print("sebelum", pokeList.data )
//                completion(pokeList.data)
//                print("suksesss:", pokeList)
//            case .failure(let dataError):
//                print("ga muncul dih")
//                print("data error", dataError)
//                print("endpoint", endPoint)
//            }
//        }
        
        
    }
    
}

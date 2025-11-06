//
//  PokemonDetailsViewModel.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/5/25.
//

import Foundation
import RxSwift
import RxRelay

protocol PokemonDetailsViewModelType {
    var input: PokemonDetailsViewModelInputs {get}
    var ouput: PokemonDetailsViewModelOuputs {get}
}

protocol PokemonDetailsViewModelInputs {
    func callApiDetailsPokemon(id: String)
}

protocol PokemonDetailsViewModelOuputs {
    
}

class PokemonDetailsViewModel: BaseViewModel {
    var pokemonID: String?
    var pokemonDetailsData = BehaviorRelay<PokemonDetailDataResults?>(value: nil)
    private let apiService = APIService()
    
  
    init(pokemonID: String = "") {
        super.init()
        self.callApiDetailsPokemon(id: pokemonID)
        }
}

extension PokemonDetailsViewModel: PokemonDetailsViewModelInputs {
   
    func callApiDetailsPokemon(id: String) {
        self.apiService.pokemonAPIDetails(id: id) { [weak self] dataSucces in
            
            guard let self = self else {return}
               
                DispatchQueue.main.async {
                    if let data = dataSucces {
                        self.pokemonDetailsData.accept(data)
                    } else {
                        print("gagal")
                    }
                }
            }
    }
}

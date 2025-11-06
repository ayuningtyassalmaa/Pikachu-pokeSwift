//
//  PokemonListViewModel.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import Foundation
import RxSwift
import RxRelay

enum PokeResponType {
    case success
    case failed
}

protocol PokemonListViewModelType {
    var input: PokemonListViewModelInputs {get}
    var ouput: PokemonListViewModelOutputs {get}
}

protocol PokemonListViewModelInputs {
    func onViewDidLoad()
    func CallApiPokemonList()
}

protocol PokemonListViewModelOutputs {
    var update: Observable<Bool> {get}
//    var showError: Observable<Error> {get}
//    var showLoadMore: Observable<Bool> {get}
    var pokemonList: Observable<PokeResponType> {get}
}

class PokemonListViewModel: BaseViewModel {
    var updateVariable = BehaviorRelay<Bool>(value:false)
//    var showError = BehaviorRelay<Bool>(value: false)
//    var showLoadMore = BehaviorRelay<Bool>(value: false)
    var pokemonListData = BehaviorRelay<[PokemonListDataResults]>(value: [])
    var pokeResultData = BehaviorRelay<PokeResponType>(value: .success)
    
    
    private let dataSuccess = BehaviorRelay<Bool>(value: false)
    private let errorAPI = BehaviorRelay<Bool>(value: false)
    private let apiService = APIService()
    
    
    override init() {
        super.init()
    }
    
    
}; extension PokemonListViewModel: PokemonListViewModelType {
    var input: PokemonListViewModelInputs {
        return self
    }
    
    var ouput: any PokemonListViewModelOutputs {
        return self
    }
    
    
}; extension PokemonListViewModel: PokemonListViewModelInputs {
    
    func onViewDidLoad() {
       CallApiPokemonList( )
    }
    
    func CallApiPokemonList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.apiService.pokemonAPICards { [weak self] successData in
                guard let self = self else {return}
                
                if let data = successData {
                    print("sukses", successData)
                    self.pokemonListData.accept(data)
                }
            }
        }
        
    }
    
}; extension PokemonListViewModel: PokemonListViewModelOutputs {
 
    var pokemonList: Observable <PokeResponType> {
        return pokeResultData.asObservable()
    }
    
    var update: RxSwift.Observable<Bool> {
        return updateVariable.asObservable()
    }
    
    var successShowingPokemonListData: Observable<[PokemonListDataResults]> {
        return pokemonListData.asObservable()
    }
}

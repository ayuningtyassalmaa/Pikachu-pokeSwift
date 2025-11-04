//
//  PokomeonListCoordinator.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import Foundation

struct PokemonListCoordinator {
    static func createPokemonListViewController() -> PokemonListViewController {
        let controller = PokemonListViewController()
        controller.viewModel = PokemonListViewModel()
        controller.coordinator = PokemonListCoordinator()
        return controller
    }
}

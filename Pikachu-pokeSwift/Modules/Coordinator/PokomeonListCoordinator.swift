//
//  PokomeonListCoordinator.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import Foundation
import UIKit

struct PokemonDetailVCCoordinator {
    static func createPokemonPokemonDetailViewController(pokemonID: String = "xy1-1") -> PokemonDetailsViewController {
        let controller = PokemonDetailsViewController(nibName: "PokemonDetailsViewController", bundle: nil)       
        controller.viewModel = PokemonDetailsViewModel.init(pokemonID: pokemonID)
        controller.coordinator = PokemonDetailVCCoordinator()
        return controller
    }
}

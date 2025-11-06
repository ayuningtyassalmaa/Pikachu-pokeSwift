//
//  PokemonDetailData.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/5/25.
//

import Foundation

struct PokemonDetailData: Codable {
    let data: PokemonDetailDataResults?
}

struct PokemonDetailDataResults: Codable {
    let id, name, supertype, hp, number, artist, rarity: String?
    let subtypes: [String]?
    let evolvesTo: [String]?
    let attacks: [Attack]?
    let weaknesses: [Weakness]?
    let retreatCost: [String]?
    let convertedRetreatCost: Int?
    let set: SetPokemon?
    let tcgplayer: TcgPlayer?
    let nationalPokedexNumbers: [Int]?
    let legalities: Legalities?
    let rules: [String]?
    let images: PokemonImages?
    }

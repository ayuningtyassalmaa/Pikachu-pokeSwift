//
//  PokemonListData.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import Foundation


struct PokemonListData: Codable {
    let data: PokemonListDataResults?
}

struct PokemonListDataResults: Codable {
    let id,name,supertype, hp, number, artist, rarity: String?
    let subtypes, evolvesTo, rules, types, retreatCost: [String]?
    let attacks: [Attacks]?
    let weaknesses: [Weaknesses]?
    let convertedRetreatCost: Int
    let set: SetPokemon?
    let tcgplayer: Tcgplayer?
    let nationalPokedexNumbers: [Int]
    let legalities: Legalities?
    let images: PokemonImages?
    
}

struct Attacks: Codable {
    let name,damage, text : String?
    let cost: [String]?
    let convertedEnergyCost: Int?
}

struct Weaknesses: Codable {
    let type, value: String?
}

struct SetPokemon :Codable {
    let id, name, series, ptcgoCode,releaseDate, updatedAt: String?
    let printedTotal: Int?
    let total: Int?
}

struct Legalities :Codable {
    let unlimited, expanded: String?
 
}

struct PokemonImages: Codable {
    let symbol, logo, small, large: String?
}

struct Tcgplayer: Codable {
    let url, updatedAt: String?
    let prices: Prices?
}

struct Prices: Codable {
    let holofoil: Holofoil?
}

struct Holofoil: Codable {
    let low,mid,high,market,directLow: Double?
}


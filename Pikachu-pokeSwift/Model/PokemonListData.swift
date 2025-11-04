//
//  PokemonListData.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import Foundation


struct PokemonListData: Codable {
    let data: [PokemonListDataResults]?
}

struct PokemonListDataResults: Codable {
    let id, name, supertype, hp, number, artist, rarity: String?
    let subtypes: [String]?
    let evolvesFrom: String?
    let abilities: [Ability]?
    let attacks: [Attack]?
    let weaknesses: [Weakness]?
    let retreatCost: [String]?
    let convertedRetreatCost: Int?
    let set: SetPokemon?
    let tcgplayer: TcgPlayer?
    let cardmarket: CardMarket?
    let nationalPokedexNumbers: [Int]?
    let legalities: Legalities?
    let images: PokemonImages?
    let flavorText: String?
}

struct Ability: Codable {
    let name, text, type: String?
}

struct Attack: Codable {
    let name, damage, text: String?
    let cost: [String]?
    let convertedEnergyCost: Int?
}

struct Weakness: Codable {
    let type, value: String?
}

struct SetPokemon: Codable {
    let id, name, series, ptcgoCode, releaseDate, updatedAt: String?
    let printedTotal: Int?
    let total: Int?
    let legalities: Legalities?
    let images: SetImages?
}

struct SetImages: Codable {
    let symbol, logo: String?
}

struct Legalities: Codable {
    let unlimited, standard, expanded: String?
}

struct PokemonImages: Codable {
    let small, large: String?
}

struct TcgPlayer: Codable {
    let url, updatedAt: String?
    let prices: TcgPrices?
}

struct TcgPrices: Codable {
    let normal: PriceDetail?
    let reverseHolofoil: PriceDetail?
}

struct PriceDetail: Codable {
    let low, mid, high, market, directLow: Double?
}

struct CardMarket: Codable {
    let url, updatedAt: String?
    let prices: CardMarketPrices?
}

struct CardMarketPrices: Codable {
    let averageSellPrice, lowPrice, trendPrice: Double?
    let germanProLow, suggestedPrice, reverseHoloSell, reverseHoloLow, reverseHoloTrend: Double?
    let lowPriceExPlus, avg1, avg7, avg30: Double?
    let reverseHoloAvg1, reverseHoloAvg7, reverseHoloAvg30: Double?
}

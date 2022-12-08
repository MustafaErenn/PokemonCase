//
//  PokemonModelDetail.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import Foundation


struct PokemonDetailModel : Codable {
    var sprites : SpriteModel?
    var stats: [StatsModel]?
    var name : String?
    var id : Int?

}

struct SpriteModel : Codable {
    var front_default: String?
    var back_female : String?
    var back_shiny : String?
    var back_shiny_female : String?
    var back_default : String?
    var front_female : String?
    var front_shiny : String?
    var front_shiny_female : String?
}

struct StatsModel : Codable {
    var base_stat, effort: Int?
    var stat: StatModel?
}

struct StatModel : Codable {
    var name: String?
    var url: String?
}

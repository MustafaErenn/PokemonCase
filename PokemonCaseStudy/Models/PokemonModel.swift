//
//  PokemonModel.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import Foundation

//struct PokemonResponseModel : Codable{
//    var results : [PokemonModel]?;
//    var count : Int?;
//}
//
//struct PokemonModel : Codable{
//    var name : String?;
//    var url : String?;
//
//    var id : String {
//        get {
//            String(self.url?.split(separator: "/")[5] ?? "");
//        }
//    }
//
//    var imageLink : String {
//        get {
//            "\(StringConstants.instance.HOME_PAGE_IMAGE_URL)\(self.id).png"
//        }
//    }
//}

struct PokemonResponseModel : Codable{
    var results : [PokemonModel]?;
    var count : Int?;
}

struct PokemonModel : Codable{
    var name : String?;
    var url : String?;
    
    var id : String {
        get {
            String(self.url?.split(separator: "/")[5] ?? "");
        }
    }
    
    var imageLink : String {
        get {
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(self.id).png";
        }
    }
}

//
//  NetworkRouteExtension.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import Foundation

extension NetworkRoutes {
    var rawValue: String {
        get {
            switch (self){
            case .home :
                return "pokemon"
            case .detail:
                return "pokemon"
            }
        }
    }
}

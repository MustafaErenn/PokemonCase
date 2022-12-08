//
//  HttpMethodsExtension.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import Foundation

extension HttpMethods{
    var rawValue: String {
        get {
            switch (self){
            case .get:
                return "GET";
            case .post:
                return "POST";
            case .put:
                return "PUT";
            case .delete:
                return "DELETE";
            }
        }
    }
}

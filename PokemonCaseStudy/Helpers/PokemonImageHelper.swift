//
//  PokemonImageHelper.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import Foundation

class PokemonImageHelper{
    
    static let instance = PokemonImageHelper()
    
    init(){}
    
    func createSpriteImageList(model : SpriteModel?) -> [String]{
        var spriteList : [String] = [];
        
        if model == nil{
            return spriteList;
        }
        
        if model!.back_default != nil {
            spriteList.append(model!.back_default!);
        }
        if model!.back_female != nil {
            spriteList.append(model!.back_female!);
        }
        if model!.back_shiny != nil {
            spriteList.append(model!.back_shiny!);
        }
        if model!.back_shiny_female != nil {
            spriteList.append(model!.back_shiny_female!);
        }
        if model!.front_default != nil {
            spriteList.append(model!.front_default!);
        }
        if model!.front_shiny != nil {
            spriteList.append(model!.front_shiny!);
        }
        if model!.front_female != nil {
            spriteList.append(model!.front_female!);
        }
        if model!.front_shiny_female != nil {
            spriteList.append(model!.front_shiny_female!);
        }
        
        return spriteList;
    }
    
}

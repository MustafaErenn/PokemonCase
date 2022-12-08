//
//  HomePageCollectionViewCell.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import UIKit
import SDWebImage

class HomePageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    
    
    func setUp(model : PokemonModel){
        self.pokemonImageView.sd_setImage(with: URL(string: model.imageLink));
        
        self.pokemonNameLabel.text = model.name;
        
        self.pokemonIdLabel.text =  "#\(model.id)"
    }
}

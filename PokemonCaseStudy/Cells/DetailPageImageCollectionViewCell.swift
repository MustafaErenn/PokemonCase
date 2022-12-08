//
//  DetailPageImageCollectionViewCell.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 8.12.2022.
//

import UIKit
import SDWebImage

class DetailPageImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    func setUp(imageLink : String){
        pokemonImage.sd_setImage(with: URL(string: imageLink));
    }
}

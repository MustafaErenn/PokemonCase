//
//  DetailPageStatCollectionViewCell.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 8.12.2022.
//

import UIKit

class DetailPageStatCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var statLabelValue: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    @IBOutlet weak var statValueProgressBar: UIProgressView!
    
    
    
    
    
    func setUp(model : StatsModel?){
        
        self.statLabelValue.text = String(model?.base_stat ?? 0)
        
        self.statLabel.text = model?.stat?.name ?? ""
        
        self.statValueProgressBar.setProgress(Float((model?.base_stat ?? 0))/100.0, animated: true)
    }
}

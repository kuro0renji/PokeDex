//
//  PokeCell.swift
//  PokeDex
//
//  Created by Hui Lin on 2016-11-03.
//  Copyright © 2016 Hui Lin. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // For each PokeCell, we gonna want to create a class of Pokemon
    // and store Pokemon class to pokemon(of type Pokemon)
    var pokemon: Pokemon!
    
    // awakeFromNib: 加载 storyboard 完毕之后调用
    // 与 innitWithCoder 同时存在会先调用 initWithCoder
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // initWithCoder: 只要对象是从文件解析来的，就会调用
    // 与 awakeFromNib 同时存在会先调用 initWithCoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    // function to update the content of each collection cell
    // and pass in pokemon(of type Pokemon)
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
    }
    
}

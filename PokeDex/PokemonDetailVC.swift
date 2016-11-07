//
//  PokemonDetailVC.swift
//  PokeDex
//
//  Created by Hui Lin on 2016-11-05.
//  Copyright © 2016 Hui Lin. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var pokedexID: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokedexID.text = "#\(pokemon.pokedexID)"
        
    }

}

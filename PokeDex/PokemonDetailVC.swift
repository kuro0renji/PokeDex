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
    
    @IBOutlet weak var topPokedexID: UILabel!
    @IBOutlet weak var topNameLbl: UILabel!
    @IBOutlet weak var mainNameLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topPokedexID.text = "#\(pokemon.pokedexID)"
        topNameLbl.text = pokemon.name.capitalized
        mainNameLbl.text = pokemon.name.uppercased()
        
    }

    @IBAction func backBtn_pressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}




























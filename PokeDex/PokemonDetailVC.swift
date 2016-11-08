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
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add 0s to pokedex ID
        if pokemon.pokedexID < 10 {
            topPokedexID.text = "#00\(pokemon.pokedexID)"
        } else if pokemon.pokedexID < 100 {
            topPokedexID.text = "#0\(pokemon.pokedexID)"
        } else {
            topPokedexID.text = "#\(pokemon.pokedexID)"
        }
        
        topNameLbl.text = pokemon.name.capitalized
        pokedexIDLbl.text = "\(pokemon.pokedexID)"
        mainNameLbl.text = pokemon.name.uppercased()
        
        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImage.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetails {
            // Only be called when the network is completed
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
    }

    @IBAction func backBtn_pressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}




























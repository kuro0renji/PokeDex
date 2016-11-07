//
//  ViewController.swift
//  PokeDex
//
//  Created by Hui Lin on 2016-11-03.
//  Copyright © 2016 Hui Lin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    // For searchBar
    var filteredPokemonArray = [Pokemon]()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        collection.dataSource = self
        collection.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initMusic()
    }
    
    // Get Audio ready
    func initMusic() {
        let musicPath = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: musicPath)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        let pokemonCSVPath = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: pokemonCSVPath!)
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = String(row["identifier"]!)!
                let poke = Pokemon(name: name, pokedexID: pokeID)
                pokemonArray.append(poke)
            }
        } 
        catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    // ---
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // ↓ 阻止读取所有718个对象，只显示屏幕上的数量的对象
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemonArray[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemonArray[indexPath.row]
                cell.configureCell(poke)
            }
            
            cell.configureCell(poke)
            
            return cell
            
        } else { // ← 如果dequeue包含对象，没有就 return UICollectionViewCell()

            return UICollectionViewCell()
            
        }
        
    }
    
    // ---
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemonArray[indexPath.row]
        } else {
            poke = pokemonArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    }
    
    // ---
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemonArray.count
        }
        return pokemonArray.count
    }
    
    // ---
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // ---
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicBtn_pressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
            sender.setTitle("", for: .normal)
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
            sender.setTitle("", for: .normal)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemonArray = pokemonArray.filter({ $0.name.range(of: lower) != nil })
            collection.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }

}


































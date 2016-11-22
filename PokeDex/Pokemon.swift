//
//  Pokemon.swift
//  PokeDex
//
//  Created by Hui Lin on 2016-11-03.
//  Copyright © 2016 Hui Lin. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        // API url
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.pokedexID)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                // Weight
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                // Height
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                // Attack
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                // Defens
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                // Types
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for index in 1..<types.count {
                            if let name = types[index]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                // Description
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>], descriptionArray.count > 0 {
                    
                    if let url = descriptionArray[0]["resource_uri"] {
                        
                        let descriptionURL = "\(BASE_URL)\(url)"
                        
                        Alamofire.request(descriptionURL).responseJSON { response in
                            let result = response.result
                            
                            if let descriptionDict = result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descriptionDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "pokemon")
                                    
                                    self._description = newDescription
                                }
                            }
                            completed()
                        }
                    }
                    
                } else {
                    
                    self._description = ""
                    
                }
                
                // Next Evolutions
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let nextEvolutionName = evolutions[0]["to"] as? String {
                        
                        // Only keep going if it's not mega evolution
                        if nextEvolutionName.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvolutionName
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolutionID = newString.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = nextEvolutionID
                                
                            }
                            
                            if let levelExist = evolutions[0]["level"] {
                                
                                if let level = levelExist as? Int {
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                
                            } else {
                                
                                self._nextEvolutionLevel = ""
                                
                            }
                        }
                    }
                }
            }
            completed()
        }
        
    }
    
}




















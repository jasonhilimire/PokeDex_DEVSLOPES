//
//  Pokemon.swift
//  pokedex3
//
//  Created by Jason Hilimire on 1/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
   
    
    //DATA PROTECTION ensure that we are getting an actual value and if we dont instead of nil just returns an empty string
    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            
            _nextEvolutionId = ""
        }
        
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
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
    
    
    var nextEvolutionText: String {
        
        if _nextEvolutionTxt == nil {
            
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var name: String {
        return _name.capitalized
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                
            }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
            
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let type = dict["types"] as? [Dictionary<String, String>] , type.count > 0{
                    
                    if let name = type[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if type.count > 1 {
                        for x in 1..<type.count {
                            
                            if let name = type[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                    print(self._type)
                    
                } else {
                    self._type = ""
                }
                
                if let descrArray = dict["descriptions"] as? [Dictionary<String, String>] , descrArray.count > 0 {
                    
                    if let url = descrArray[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                    
                        Alamofire.request(descURL).responseJSON { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, Any> {
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                    print(newDescription)
                                }
                            }
                            
                            completed()
                        }
                    } else {
                        self._description = ""
                    }
               
            }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    
                                    if let lvl = lvlExist as? Int {
                                        
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                    
                                } else {
                                    
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                    print(self.nextEvolutionId)
                    print(self.nextEvolutionName)
                    print(self.nextEvolutionLevel)
                }
            
            }
          completed()
        }
        
    }
    
    
}



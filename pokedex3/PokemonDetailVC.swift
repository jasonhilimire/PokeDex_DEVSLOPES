//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Jason Hilimire on 1/30/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        
    }

    


}

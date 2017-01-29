//
//  ViewController.swift
//  pokedex3
//
//  Created by Jason Hilimire on 1/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate = self
        
        parsePokemonCSV()
    }
    
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!  // call the path of the csv file
        
        do {                                                                // get the contents of the csv file & then set them to class POKEMON base on their row & append them to the pokemon array
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokedId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokedId)
                pokemon.append(poke)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
// deques the cell and sets it up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke = pokemon[indexPath.row]
            cell.configureCell(pokemon: poke)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    
// tells what to do when select the cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
// sets the number of items in collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
// sets the number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
  
    }

}


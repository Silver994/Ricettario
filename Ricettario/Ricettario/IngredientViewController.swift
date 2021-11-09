//
//  DetailViewController.swift
//  Ricettario
//
//  Created by Gennaro Cotarella on 07/01/2021.
//  Copyright © 2021 Gennaro Cotarella. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {
    
    var ingredientsRecipe: [String] = []
    var recipe: [Recipe]?
    var titleRecipe: String?
    var indexRecipe: Int?
    var indexIngredientToPass: Int?
    var stringProva: String?
    
    @IBOutlet weak var ingredientTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        
        ingredientTableView.backgroundColor = UIColor.init(red: 255/255, green: 223/255, blue: 150/255, alpha: 1.0)
        print(titleRecipe)
        navigationItem.title = "Ciao"
        
        getJSON()
    }
    
    func getJSON() {
        let url = URL(string: "https://d17h27t6h515a5.cloudfront.net/topher/2017/May/59121517_baking/baking.json")!
         
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                
                self.recipe = try? JSONDecoder().decode([Recipe].self, from: data)
                
                let ingredientArray = self.recipe![self.indexRecipe!].ingredients
                
                for ingredient in ingredientArray {
                    self.ingredientsRecipe.append(ingredient.ingredient)
                }
                
            }
            DispatchQueue.main.async {
                self.ingredientTableView.reloadData()
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailViewController {
            vc.indexIngredient = indexIngredientToPass
            vc.indexRecipe = indexRecipe
            vc.intProva = indexIngredientToPass
            vc.stringProva = stringProva
        }
    }
}

extension IngredientViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = ingredientsRecipe[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let indexSelected = indexPath.row
        let nameToTry = ingredientsRecipe[indexPath.row]
        indexIngredientToPass = indexSelected
        stringProva = nameToTry
        
        performSegue(withIdentifier: "segueToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingredients"
    }
}

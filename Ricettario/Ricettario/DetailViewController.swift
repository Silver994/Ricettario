//
//  IngredientViewController.swift
//  Ricettario
//
//  Created by Gennaro Cotarella on 11/01/2021.
//  Copyright © 2021 Gennaro Cotarella. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    var quantity: String?
    var measure: String?
    var dosage: [String] = []
    var indexRecipe: Int?
    var indexIngredient: Int?
    var intProva: Int?
    var stringProva: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.backgroundColor = UIColor.init(red: 255/255, green: 223/255, blue: 150/255, alpha: 1.0)
        print(indexRecipe)
        print(indexIngredient as Any)
        getJSON()
        
    }
    
    func getJSON() {
        let url = URL(string: "https://d17h27t6h515a5.cloudfront.net/topher/2017/May/59121517_baking/baking.json")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                
                let recipeHere = try? JSONDecoder().decode([Recipe].self, from: data)
                
                self.quantity = String(recipeHere![self.indexRecipe!].ingredients[self.indexIngredient!].quantity)
                self.measure = recipeHere![self.indexRecipe!].ingredients[self.indexIngredient!].measure

                self.dosage.append("Quantity: \(self.quantity!)")
                self.dosage.append("Measure: \(self.measure!)")
                
            }
        }.resume()
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dosage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .clear
        cell.textLabel?.text = dosage[indexPath.row]
        
        return cell
    }
    
}

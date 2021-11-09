//
//  ViewController.swift
//  Ricettario
//
//  Created by Gennaro Cotarella on 04/01/2021.
//  Copyright © 2021 Gennaro Cotarella. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var nameRecipe: [String] = []
    var dataRecipe: [Int] = []
    var recipe: [Recipe]?
    var newRecipe: Prova?
    let urlJSON: String = "https://d17h27t6h515a5.cloudfront.net/topher/2017/May/59121517_baking/baking.json"
    var indexToPass: Int?
    var nameRecipeToPass: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Cookbook"
        tableView.backgroundColor = UIColor.init(red: 255/255, green: 223/255, blue: 150/255, alpha: 1.0)
        //        tableView.backgroundColor = UIColor.init(red: 159/255, green: 254/255, blue: 222/255, alpha: 1.0)
        
        getJSON()

    }
    
    
    func getJSON() {
        
        let headers = [
            "x-rapidapi-key": "f0302118bf4141efa0560b1eef6e89c3",
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=f0302118bf4141efa0560b1eef6e89c3&query=pasta&maxFat=25&number=2")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                print(data!)
            }
            
            do {
                self.newRecipe = try? JSONDecoder().decode(Prova.self, from: data!)
                print(self.newRecipe)
                self.dataRecipe.append(self.newRecipe!.offset)
                print(self.dataRecipe)
                //for i in self.newRecipe! {
                //    self.dataRecipe?.append(i.offset)
                //    print(self.dataRecipe)
                //}
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        dataTask.resume()
    }
    
    
    /*
    func getJSON() {
        let url = URL(string: "https://d17h27t6h515a5.cloudfront.net/topher/2017/May/59121517_baking/baking.json")
        
        var task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error1")
                return
            }
            
            //take data
            do {
                self.recipe = try JSONDecoder().decode([Recipe].self, from: data)
                for i in self.recipe! {
                    self.nameRecipe.append(i.name)
                }
            } catch {
                print("Failed to convert: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
       
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let barVC = segue.destination as? UITabBarController {
            barVC.viewControllers?.forEach({
                if let vc = $0 as? IngredientViewController {
                    vc.titleRecipe = nameRecipeToPass
                    vc.indexRecipe = indexToPass
                }
            })
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(dataRecipe[indexPath.row])"
        cell.backgroundColor = UIColor.clear
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let indexSelectedRecipe = indexPath.row
        let nameSelectedRecipe = nameRecipe[indexPath.row]
        indexToPass = indexSelectedRecipe
        nameRecipeToPass = nameSelectedRecipe
        
        performSegue(withIdentifier: "segueToTabBar", sender: self)
    }
}

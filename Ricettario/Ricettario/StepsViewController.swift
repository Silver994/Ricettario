//
//  StepsViewController.swift
//  Ricettario
//
//  Created by Gennaro Cotarella on 18/01/2021.
//  Copyright © 2021 Gennaro Cotarella. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StepsViewController: UIViewController {
    
    var recipe: [Recipe]?
    var indexRecipe: Int?
    var numberStepsRecipeArray: [String] = []
    var descriptionStepsArray: [String] = []
    var videoStepsArray: [String] = []
    var titleRecipeSteps: String?
    
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    @IBOutlet weak var stepsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        
        stepsTableView.backgroundColor = UIColor.init(red: 255/255, green: 223/255, blue: 150/255, alpha: 1.0)
        
        // Do any additional setup after loading the view.
        
        let secondTabBar = (self.tabBarController?.viewControllers![0])! as! IngredientViewController
        self.indexRecipe = secondTabBar.indexRecipe
        self.titleRecipeSteps = secondTabBar.titleRecipe
        print(self.titleRecipeSteps)
        navigationItem.title = titleRecipeSteps!
        
        getJSON()
    }
    
    func getJSON() {
        let url = URL(string: "https://d17h27t6h515a5.cloudfront.net/topher/2017/May/59121517_baking/baking.json")!
         
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                
                self.recipe = try? JSONDecoder().decode([Recipe].self, from: data)
                
                let stepsArray = self.recipe![self.indexRecipe!].steps
                
                for stepsID in stepsArray {
                    self.numberStepsRecipeArray.append("\(stepsID.id)")
                }
                
                for stepDesc in stepsArray {
                    self.descriptionStepsArray.append(stepDesc.description)
                }
                
                for stepVideo in stepsArray {
                    self.videoStepsArray.append(stepVideo.videoURL)
                }
                
            }
            DispatchQueue.main.async {
                self.stepsTableView.reloadData()
            }
        }.resume()
    }
    
}

extension StepsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberStepsRecipeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stepsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StepsTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.labelStep.text = "Step: \(numberStepsRecipeArray[indexPath.row])"
        cell.textViewDescription.text = descriptionStepsArray[indexPath.row]
        cell.textViewDescription.backgroundColor = UIColor.init(red: 255/255, green: 195/255, blue: 104/255, alpha: 1.0)
        
        if !videoStepsArray[indexPath.row].isEmpty {
            cell.labelCheckVideo.text = "Watch the video tutorial!"
        } else {
            cell.labelCheckVideo.text = "No video tutorial for this step!"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stepsTableView.deselectRow(at: indexPath, animated: true)
        playVideo(at: indexPath)
    }
    
    func playVideo(at indexPath: IndexPath) {
        
        if !videoStepsArray[indexPath.row].isEmpty {
            let videoUrl = URL(string: videoStepsArray[indexPath.row])
            
            player = AVPlayer(url: videoUrl!)
            playerViewController.player = player
            
            self.present(playerViewController, animated: true, completion: {
                self.playerViewController.player?.play()
            })
        } else {
            print("No video tutorial.")
        }
    }
    
}

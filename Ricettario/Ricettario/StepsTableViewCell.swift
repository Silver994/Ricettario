//
//  StepsTableViewCell.swift
//  Ricettario
//
//  Created by Gennaro Cotarella on 18/01/2021.
//  Copyright © 2021 Gennaro Cotarella. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StepsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelStep: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var labelCheckVideo: UILabel!
    @IBOutlet weak var imageToPlay: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

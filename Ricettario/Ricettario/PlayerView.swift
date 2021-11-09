//
//  PlayerView.swift
//  Ricettario
//
//  Created by Gennaro Cotarella on 19/01/2021.
//  Copyright © 2021 Gennaro Cotarella. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerView: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        
        get {
            return playerLayer.player
        }
        
        set {
            playerLayer.player = newValue
        }
    }
}

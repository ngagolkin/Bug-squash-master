//
//  Background.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    
    var backgroundImageNames: [String] = [
        "background_wood",
        "background_concrete",
        "background_metal",
        "background_rocky",
    ]
    
    init(mainScene: SKNode) {
        
        super.init(texture: nil, color: UIColor.clearColor(), size: mainScene.frame.size)
        position = CGPointMake(mainScene.frame.size.width / 2, mainScene.frame.size.height / 2)
        
        let backgroundImageNumber: Int = NSUserDefaults.standardUserDefaults().integerForKey("SelectedStoreButton")
        
        texture = SKTexture(imageNamed: backgroundImageNames[backgroundImageNumber])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
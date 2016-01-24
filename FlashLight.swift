//
//  FlashLight.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class FlashLight: SKSpriteNode {
    
    init(mainScene: SKNode) {
        
        super.init(texture: SKTexture(imageNamed: "hand_flashlight"), color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.width, mainScene.frame.size.height))
        position = CGPointMake(mainScene.frame.size.width - frame.size.width / 2, mainScene.frame.size.height - frame.size.height / 2)
        zRotation = CGFloat(M_PI)
        zPosition = 800
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

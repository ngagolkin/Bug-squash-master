//
//  Net.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class Web: SKSpriteNode {
    
    init(mainScene: SKNode) {
        
        super.init(texture: SKTexture(imageNamed: "web_foreground"), color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.width, mainScene.frame.size.height))
        position = CGPointMake(mainScene.frame.size.width - frame.size.width / 2, mainScene.frame.size.height - frame.size.height / 2)
        self.userInteractionEnabled = false
        zPosition = 900

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

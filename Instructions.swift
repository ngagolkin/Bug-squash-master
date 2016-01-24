//
//  Instructions.swift
//  Bug squash
//
//  Created by Darvydas on 05/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class Instructions: SKSpriteNode {
    
    init(mainScene: SKNode) {
        
        super.init(texture: SKTexture(imageNamed: "instructions.png"), color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.width, mainScene.frame.size.height / 32 * 32))
        position = CGPointMake(mainScene.frame.size.width / 2, mainScene.frame.size.height / 32 * 16)
        userInteractionEnabled = true
        zPosition = 900
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        AppDelegate().playMusicOnetime("Button", withExtension: "wav")
        removeFromParent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

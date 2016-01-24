//
//  WordButton.swift
//  Bug squash
//
//  Created by Darvydas on 05/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class CustomButton: SKSpriteNode {
    
    init(mainScene: SKNode, buttonName: String, buttonSize: CGSize, buttonPosition: CGPoint) {
        
        super.init(texture: SKTexture(imageNamed: buttonName), color: UIColor.clearColor(), size: buttonSize)
        position = buttonPosition
        name = buttonName
        zPosition = 500
        
    }
    
    func changeImage() {
                
        var textureName: String
        
        if name == "playgame_off_btn" {
            textureName = "playgame_on_btn"
        } else if name == "instruction_off_btn" {
            textureName = "instruction_on_btn"
        } else if name == "store_off_btn"{
            textureName = "store_on_btn"
        } else if name == "mainmenu_off_btn" {
            textureName = "mainmenu_on_btn"
        } else {
            textureName = "playagain_on_btn"
        }
        
        runAction(SKAction.sequence([
            SKAction.setTexture(SKTexture(imageNamed: textureName)),
            SKAction.waitForDuration(1.00),
            SKAction.setTexture(SKTexture(imageNamed: self.name!)),
            ]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}